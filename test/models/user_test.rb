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
end
