class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.settings.mail.from
  layout 'emails/email'

  before_action :add_images

  private
  def add_images
  end
end
