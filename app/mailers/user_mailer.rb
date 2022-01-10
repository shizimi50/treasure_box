class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #

  def account_activations(user)
    @user = user
    mail to: user.email, subject: "Account activation"
    @greeting = 'Hi'
  end
  
  def password_reset
    @greeting = 'Hi'
    mail to: "to@example.org" # メールの宛先
  end

end
