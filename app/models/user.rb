class User < ActiveRecord::Base
  acts_as_paranoid

  paginates_per 5

  attr_accessor :login

  include Concerns::UserImagesConcern

  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  enum role: [:admin, :dealer, :service_advisor, :technician]

  validates :email, presence: {message: 'or Username required'}, :if => Proc.new { |user| user.email.blank? && user.username.blank? }
  validates :username, presence: {message: 'or Email required'}, :if => Proc.new { |user| user.email.blank? && user.username.blank? }
  validates :username, uniqueness: true, format: {with: /\A[a-z0-9\-_]+\z/i}, allow_blank: true
  validates :dealership_id, presence: true, if: proc {|user| user.role != 'admin'}
  validates :role, presence: true

  has_many :authentications, validate: false, inverse_of: :user do
    def grouped_with_oauth
      includes(:oauth_cache).group_by { |a| a.provider }
    end
  end

  has_many :vehicle_report_cards
  belongs_to :dealership

  after_create :send_welcome_emails, :unless => Proc.new { |user| user.technician? }

  rails_admin do
    list do
      field :id
      field :first_name
      field :last_name
      field :email
      field :dealership
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :confirmed_at
      field :created_at
      field :updated_at

    end

    edit do
      field :first_name
      field :last_name
      field :email
    end
  end

  def roles_for_select_box
    if admin?
      User.roles.keys.to_a
    elsif dealer?
      ['dealer', 'service_advisor', 'technician']
    elsif service_advisor?
      ['technician']
    elsif technician?
      ['technician']
    end
  end

  def invitable_roles
    if admin?
      User.roles.keys.to_a - ['technician']
    elsif dealer?
      ['dealer', 'service_advisor']
    else
      []
    end
  end

  def accessible_vehicle_report_cards
    if admin?
      VehicleReportCard.all
    elsif dealer? or service_advisor?
      VehicleReportCard.where(vehicle_report_cards: {user_id: dealership.users})
    else
      vehicle_report_cards
    end
  end

  def display_name
    first_name.presence || email.split('@')[0] || username.presence
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name_or_email_or_username
    name.presence || email.presence || username.presence
  end

  # Case insensitive email lookup.
  #
  # See Devise.config.case_insensitive_keys.
  # Devise does not automatically downcase email lookups.
  def self.find_by_email(email)
    find_by(email: email.downcase) if email.present?
    # Use ILIKE if using PostgreSQL and Devise.config.case_insensitive_keys=[]
    #where('email ILIKE ?', email).first
  end

  # Override Devise to allow for Authentication or password.
  #
  # An invalid authentication is allowed for a new record since the record
  # needs to first be saved before the authentication.user_id can be set.
  def password_required?
    if authentications.empty?
      super || encrypted_password.blank?
    elsif new_record?
      false
    else
      super || encrypted_password.blank? && authentications.find { |a| a.valid? }.nil?
    end
  end

  # Merge attributes from Authentication if User attribute is blank.
  #
  # If User has fields that do not match the Authentication field name,
  # modify this method as needed.
  def reverse_merge_attributes_from_auth(auth)
    auth.oauth_data.each do |k, v|
      self[k] = v if self.respond_to?("#{k}=") && self[k].blank?
    end
  end

  # Do not require email confirmation to login or perform actions
  def confirmation_required?
    false
  end

  def send_welcome_emails
    #UserMailer.welcome_email(self.id).deliver_now
  end

  def email_required?
    false if Proc.new { |user| user.technician? }
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end