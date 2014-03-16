require 'test_helper'

class SubscriptionUsageTest < ActiveSupport::TestCase
  setup do
    @subscription = subscriptions(:pakar_subscription)
    @subscription_usage = SubscriptionUsage.new(@subscription.center)
  end

  test "should return the correct max" do
    assert_equal 1000, @subscription_usage.max
  end

  test "should return the correct current usage of the subscription" do
    assert_equal 3, @subscription_usage.current
  end

  test "should return balance for the subscription usage" do
    assert_equal 997, @subscription_usage.balance
  end
end
