require 'test_helper'

class Settings::CreditsControllerTest < ActionController::TestCase
  setup do
    @settings_credit = settings_credits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:settings_credits)
  end

  test "should show settings_credit" do
    get :show, id: @settings_credit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @settings_credit
    assert_response :success
  end
end
