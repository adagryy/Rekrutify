class PasswordResetNotifier < ApplicationMailer
  def password_reset_instructions(user)
    @url  = edit_password_reset_url(token: user.perishable_token)

    mail(to: user.mail, subject: "Password Reset Instructions")
  end
end
