require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)

    sign_in @admin
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should show user" do
    get :show, id: @admin

    assert_response :success
  end
end
