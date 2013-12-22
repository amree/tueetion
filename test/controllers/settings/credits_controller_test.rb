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

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create settings_credit" do
    assert_difference('Settings::Credit.count') do
      post :create, settings_credit: { amount: @settings_credit.amount, center_id: @settings_credit.center_id, count: @settings_credit.count, paid_at: @settings_credit.paid_at, payment_method: @settings_credit.payment_method, transaction_number: @settings_credit.transaction_number }
    end

    assert_redirected_to settings_credit_path(assigns(:settings_credit))
  end

  test "should show settings_credit" do
    get :show, id: @settings_credit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @settings_credit
    assert_response :success
  end

  test "should update settings_credit" do
    patch :update, id: @settings_credit, settings_credit: { amount: @settings_credit.amount, center_id: @settings_credit.center_id, count: @settings_credit.count, paid_at: @settings_credit.paid_at, payment_method: @settings_credit.payment_method, transaction_number: @settings_credit.transaction_number }
    assert_redirected_to settings_credit_path(assigns(:settings_credit))
  end

  test "should destroy settings_credit" do
    assert_difference('Settings::Credit.count', -1) do
      delete :destroy, id: @settings_credit
    end

    assert_redirected_to settings_credits_path
  end
end
