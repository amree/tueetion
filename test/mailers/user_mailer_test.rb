require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @invitation = invitations(:unused)
  end

  test "invitation email" do
    email = UserMailer.invitation(@invitation).deliver

    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [@invitation.email], email.to
    assert email.body.to_s.match(/#{@invitation.key}/).present?
  end
end
