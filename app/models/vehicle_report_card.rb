class VehicleReportCard < ActiveRecord::Base
  include AASM

  aasm do
    state :to_be_reviewed, :initial => true
    state :reviewed
    state :sent_to_customer

    event :review do
      transitions :from => :to_be_reviewed, :to => :reviewed
    end

    event :send_to_customer do
      transitions :from => :reviewed, :to => :sent_to_customer
    end
  end

  acts_as_paranoid

  VIN_LENGTH = 17
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  paginates_per 5

  belongs_to :user

  has_one :next_maintenance_appointment, dependent: :destroy, :inverse_of => :vehicle_report_card
  has_one :brake_wear_indicate, dependent: :destroy, :inverse_of => :vehicle_report_card
  has_one :tire_wear_indicate, dependent: :destroy, :inverse_of => :vehicle_report_card
  has_one :vehicle_component, dependent: :destroy, :inverse_of => :vehicle_report_card
  has_one :battery, dependent: :destroy, :inverse_of => :vehicle_report_card
  has_one :wiper_blade, dependent: :destroy, :inverse_of => :vehicle_report_card
  has_one :fluid_level, dependent: :destroy, :inverse_of => :vehicle_report_card
  has_one :scheduled_maintenance_item, dependent: :destroy, :inverse_of => :vehicle_report_card

  accepts_nested_attributes_for :next_maintenance_appointment, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :brake_wear_indicate, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :tire_wear_indicate, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :vehicle_component, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :battery, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :wiper_blade, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :fluid_level, allow_destroy: true, update_only: true
  accepts_nested_attributes_for :scheduled_maintenance_item, allow_destroy: true, update_only: true

  validates :vehicle_identification_number, presence: true
  validates :vehicle_identification_number, length: { is: VIN_LENGTH }
  validates :customer_email, allow_blank: true, format: {with: VALID_EMAIL_REGEX }
  validates :odometer, numericality: {greater_than: 0}, presence: true
  validates :user_id, presence: true

  before_validation :validate_odometer
  after_create :notify_service_advisor

  def validate_odometer
    comparision_time = new_record? ? Time.zone.now : self.created_at
    vehilcle_report_card_previous = VehicleReportCard.where(vehicle_identification_number: self.vehicle_identification_number).where("created_at < ?", comparision_time).order("created_at asc").last
    vehilcle_report_card_next = VehicleReportCard.where(vehicle_identification_number: self.vehicle_identification_number).where("created_at > ?", comparision_time).order("created_at asc").first

    if vehilcle_report_card_previous && (self.odometer.to_i < vehilcle_report_card_previous.odometer.to_i)
      self.errors.add(:odometer, "cannot be lesser than previous reports. Previous report has odometer been set at #{vehilcle_report_card_previous.odometer}.") && false
    elsif vehilcle_report_card_next && (self.odometer.to_i > vehilcle_report_card_next.odometer.to_i)
      self.errors.add(:odometer, "cannot be greater than next reports. Next report has odometer been set with #{vehilcle_report_card_next.odometer}.") && false
    else
      true
    end
  end

  def aasm_state_label_css_class
    if to_be_reviewed?
      'label-danger'
    elsif reviewed?
      'label-warning'
    elsif sent_to_customer?
      'label-success'
    else
      'label-default'
    end
  end

  def notify_service_advisor
    VehicleReportCardMailer.notify_service_advisor(self).deliver_now if user.technician? && service_advisor.try(:email).present?
  end

  def self.report_cards(user)
    where('user_id in (?)',(user.dealership.users).pluck(:id)).pluck(:id)
  end

  # Convert datetime from string to datetime object
  def self.set_date(card_date)
    DateTime.strptime(card_date, '%m/%d/%Y %H:%M %P').utc
  end

  def technician
    User.unscoped.find(technician_id) if technician_id.present?
  end

  def inventory_exists?
    inventories.count > 0
  end

  def inventories
    Inventory.where(vin: vehicle_identification_number)
  end

  def inventory
    inventories.first
  end

  def email_report(pdf)
    VehicleReportCardMailer.email_report_card(self, pdf, user.dealership).deliver_now
    send_to_customer! unless sent_to_customer?
  end

  def service_advisor
    User.where(id: service_advisor_id).first
  end
end