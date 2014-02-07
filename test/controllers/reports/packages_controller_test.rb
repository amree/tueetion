require 'test_helper'

class Reports::PackagesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:user)
  end

  test "should redirect for non owner" do
    sign_out users(:user)
    sign_in  users(:staff)

    get :index

    assert_redirected_to root_path
  end

  test "should get index" do
    get :index

    assert_response :success
  end
end
