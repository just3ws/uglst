class MailPreview < MailView
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end
end
