require 'test_helper'

class Reports::RegistrationsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:user)
  end

  test "should get index" do
    get :index

    assert_response :success
  end
end
