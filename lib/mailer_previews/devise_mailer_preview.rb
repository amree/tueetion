class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    DeviseMailer.reset_password_instructions(User.first, {})
  end
end
