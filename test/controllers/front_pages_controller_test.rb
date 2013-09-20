require 'test_helper'

class FrontPagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index

    assert_response :success
  end

  test "should be redirected to dashboards#index" do
    sign_in users(:user)

    get :index

    assert_redirected_to dashboards_index_path
  end
end
