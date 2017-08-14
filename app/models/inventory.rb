class Inventory < ActiveRecord::Base
  acts_as_paranoid

  validates :vin, :data_one_vehicle_id, presence: true

  attr_accessor :name

  has_one :pricing
  has_one :safety_equipment

  has_many :epa_mpg_records
  has_many :epa_green_score_records
  has_many :exterior_colors
  has_many :interior_colors
  has_many :roof_colors
  has_many :specifications
  has_many :warranties

  has_many :engines_inventories
  has_many :engines, through: :engines_inventories

  has_many :inventories_transmissions
  has_many :transmissions, through: :inventories_transmissions

  has_many :inventories_options
  has_many :options, through: :inventories_options

  has_many :equipments_inventories
  has_many :equipments, through: :equipments_inventories

  has_many :inventories_specifications
  has_many :specifications, through: :inventories_specifications


  accepts_nested_attributes_for :pricing, allow_destroy: true, reject_if: :all_blank, update_only: true
  accepts_nested_attributes_for :safety_equipment, allow_destroy: true, reject_if: :all_blank, update_only: true

  accepts_nested_attributes_for :engines, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :epa_mpg_records, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :epa_green_score_records, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :exterior_colors, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :interior_colors, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :roof_colors, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :transmissions, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :warranties, allow_destroy: true, reject_if: :all_blank


  class << self
    def decode_vin_and_save(vin)
      inventory = Inventory.new
      begin
        Rails.logger.info "====> Decoding #{vin}..."

        if vin.to_s.strip.size == VehicleReportCard::VIN_LENGTH

          data_one_software = VinDecoder::DataOneSoftware.new
          data_one_software.decode(vin)

          if !data_one_software.has_errors?
            inventory = Inventory.create(data_one_software.inventory_attributes.merge(vin: vin))
          else
            inventory.errors.add :base, data_one_software.errors.map { |error| error['message'] }.join(', ')
          end
        else
          inventory.errors.add(:base, "VIN should be #{VehicleReportCard::VIN_LENGTH} in length. Failed to query dataone and save in inventory.")
        end
      rescue => e
        Rails.logger.info e.backtrace

        inventory.errors.add(:base, e.message)
      end

      Rails.logger.info "====> Errors - #{inventory.errors.full_messages.join(', ')}"

      inventory
    end
  end
end
