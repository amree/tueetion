require 'test_helper'

class Settings::SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @subscription = subscriptions(:pakar_subscription)

    sign_in users(:user)
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should get subscription" do
    get :show, id: @subscription

    assert_response :success
  end
end
