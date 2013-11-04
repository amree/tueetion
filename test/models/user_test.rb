require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
  end

  test "first and last name must not be nil" do
    user = User.new
    user.email = "otheremail@mail.com"
    user.password = "password"

    user.invalid?

    assert user.errors[:first_name].present?
    assert user.errors[:last_name].present?
  end

  test "should have valid center" do
    user = users(:user)

    user.center_id = 123

    assert user.invalid?
    assert user.errors[:center].present?
  end

  test "should create the correct staff" do
    invitation = invitations(:unused)

    user = User.new
    user.first_name = "First Name"
    user.last_name = "Last Name"
    user.password = "thisisapassword"
    user.password_confirmation = "thisisapassword"
    user.key = invitation.key

    assert user.save
    assert user.email == invitation.email
    assert user.access_level == 10,
           "User should be created as a staff when given a key"
    assert user.center_id = invitation.center_id,
           "Center is not associated correctly"

    assert Invitation.find(invitation.id).is_used
  end
end
