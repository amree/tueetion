require 'test_helper'

class Settings::AccountsControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)

    sign_in users(:user)
  end

  test "should get edit profile" do
    get :edit

    assert_response :success
  end

  test "should update profile" do
    patch :update, user: { first_name: @user.first_name, last_name: @user.last_name, email: @user.email }

    assert_redirected_to edit_settings_accounts_path
  end


  test "should get edit password" do
    get :edit_password

    assert_response :success
  end

  test "should update password" do
    patch :update_password, user: { password: "password", password_confirmation: "password", current_password: "password" }

    assert_redirected_to edit_password_settings_accounts_path
  end
end
