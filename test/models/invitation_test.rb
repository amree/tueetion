require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  setup do
    @center = centers(:pakar)
    @unused = invitations(:unused)
  end

  test "should have created a key for an invitation" do
    invitation = Invitation.new
    invitation.center_id = @center.id
    invitation.email = "random@mail.com"
    invitation.save

    assert invitation.key.present?
  end

  test "email should be unique" do
    dup = @unused.dup

    assert dup.invalid?
    assert dup.errors[:email].present?
  end

  test "key should not be changed during update" do
    key = @unused.key
    @unused.is_used = true
    @unused.save

    assert key, @unused.key
  end
end
