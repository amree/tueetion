require 'test_helper'

class Admin::SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @subscription = subscriptions(:pakar_subscription)
    @transaction = transactions(:subscription_payment)

    sign_in @admin
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create subscription" do
    subscription = @subscription.attributes.except(:id, :created_at, :updated_at)
    transaction = @transaction.dup.attributes.except(:id, :created_at, :updated_at)

    attributes = subscription.merge(transactions_attributes: transaction)

    assert_difference('Transaction.count') do
      assert_difference('Subscription.count') do
        post :create, subscription: attributes
      end
    end

    assert_redirected_to admin_subscription_path(assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription

    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription

    assert_response :success
  end

  test "should update subscription" do
    patch :update, id: @subscription, subscription: @subscription.attributes

    assert_redirected_to admin_subscription_path(assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Transaction.count', -1) do
      assert_difference('Subscription.count', -1) do
        delete :destroy, id: @subscription
      end
    end

    assert_redirected_to admin_subscriptions_path
  end
end
