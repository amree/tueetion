class UserMailerPreview < ActionMailer::Preview
  def invitation
    UserMailer.invitation(Invitation.first)
  end
end
