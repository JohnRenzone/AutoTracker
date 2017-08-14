class UserMailer < ApplicationMailer
  def welcome_email(user)
    return false unless load_user(user).present?
    @dealership = user.dealership
    mail to: @user.email, subject: I18n.t('emails.welcome.subject')
  end

  protected

  def load_user(user)
    @user = user.is_a?(User) ? user : User.find(user)
  end
end
