require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    sign_in users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    @user = users(:user)

    get :show, id: @user
    assert_response :success
  end
end
