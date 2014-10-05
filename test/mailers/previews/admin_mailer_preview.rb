class AdminMailerPreview < ActionMailer::Preview
  def new_user
    AdminMailer.new_user(User.first)
  end
end
