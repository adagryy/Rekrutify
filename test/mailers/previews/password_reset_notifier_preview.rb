# Preview all emails at http://localhost:3000/rails/mailers/password_reset_notifier
class PasswordResetNotifierPreview < ActionMailer::Preview
  def password_reset
  	user = User.find_by_id(1)
    # user.perishable_token = User.perishable_token
  	PasswordResetNotifier.password_reset_instructions(user)
    # PasswordResetNotifier.password_reset_instructions
  end
end
