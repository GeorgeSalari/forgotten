class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.full_name} <#{user.email}>", subject: "Подтвердите пожалуйста регистрацию.")
  end

  def reset_user_password(user)
    @user = user
    mail(:to => '#{user.full_name} #{user.email}', subject: "Восстановления пароля.")
  end
end
