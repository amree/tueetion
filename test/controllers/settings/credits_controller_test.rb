require 'test_helper'

class Settings::CreditsControllerTest < ActionController::TestCase
  setup do
    @credit = credits(:credit_pakar)

    sign_in users(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:credits)
  end

  test "should show credit" do
    get :show, id: @credit
    assert_response :success
  end
end
