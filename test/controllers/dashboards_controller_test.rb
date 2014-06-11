require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:user)
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should be forwarded to admin_centers_path if admin" do
    sign_in users(:admin)

    get :index

    assert_redirected_to admin_centers_path
  end
end
