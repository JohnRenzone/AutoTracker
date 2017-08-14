class CustomDeviseMailer < Devise::Mailer
  before_action :add_images

  def confirmation_instructions(record, token, opts={})
    @dealership = record.dealership
    super
  end

  def reset_password_instructions(record, token, opts={})
    @dealership = record.dealership
    super
  end

  def unlock_instructions(record, token, opts={})
    @dealership = record.dealership
    super
  end

  def password_change(record, opts={})
    @dealership = record.dealership
    super
  end

  private
  def add_images
  end
end