require 'test_helper'

class Settings::AccountsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:user)
  end

  test "should get edit profile" do
    get :edit
    assert_response :success
  end

  test "should get update profile" do
    patch :update
    assert_response :success
  end
end
