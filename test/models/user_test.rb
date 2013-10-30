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
end
