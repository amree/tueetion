require 'test_helper'
require 'bill_calculator.rb'

class BillCalculatorTest < ActiveSupport::TestCase
  setup do
    @ali = students(:ali)
  end

  test "should get the correct amount of unpaid" do
    calc = BillCalculator.new(@ali)

    assert_equal BigDecimal.new('30.0'), calc.get_unpaid_amount
  end

  test "should get the correct unpaid bill count" do
    calc = BillCalculator.new(@ali)

    assert_equal 1, calc.get_unpaid_bill_count
  end
end
