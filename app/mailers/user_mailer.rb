class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.full_name} <#{user.email}>", subject: "Please comfirm your registration")
  end
end
