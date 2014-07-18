require 'test_helper'

class CreditTest < ActiveSupport::TestCase
  setup do
    @center = centers(:pakar)
  end

  test "creating new credit should increase credit balance in Center" do
    amount = 500

    old_balance = @center.credit_balance

    credit = Credit.new
    credit.center = @center
    credit.amount = amount
    credit.save

    @center.reload

    assert_equal @center.credit_balance - old_balance, BigDecimal.new(amount)
  end
end
