class UserMailer < ActionMailer::Base
  default from: 'mike+welcome@ugl.st'

  def welcome(user_id)
    @user = User.find(user_id)
    @profile_url = profile_url(@user)
    @user_group_url = new_user_group_url

    mail(to: @user.email, subject: 'Welcome to User-Group List!')
  end
end
