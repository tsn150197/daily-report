class UserMailer < ApplicationMailer
  def password_reset user
    @user = user
    email_with_name = %("#{user.user_profile.name}" <#{user.email}>)
    attachments.inline["image.jpg"] = File.read "app/assets/images/"\
      "forgot-password.jpg"
    mail to: email_with_name, subject: t(".password_reset")
  end
end
