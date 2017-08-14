class Devise::MailerPreview < ActionMailer::Preview

  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(User.first, "faketoken")
  end

  def invitation_instructions
    #ToDo
  end

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(FactoryGirl.attributes_for(:user), "faketoken")
  end
end