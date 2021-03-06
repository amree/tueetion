class UserMailer < ActionMailer::Base
  default from: "Tueetion <noreply@tueetion.com>"

  def invitation(invitation)
    @key = invitation.key

    headers['X-MC-Tags'] = "invitation"

    mail to: invitation.email, subject: "Invitation to use Tueetion"
  end
end
