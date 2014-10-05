class AdminMailer < ActionMailer::Base
  default from: 'Tueetion <noreply@tueetion.com>'

  def new_user(user)
    @user = user

    mail to: Rails.application.secrets.admin_email,
         subject: "New User Registration ##{User.count}"
  end
end
