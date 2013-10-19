require 'test_helper'

class BillTest < ActiveSupport::TestCase
  setup do
    @ali = students(:ali)
  end

  test "should generate bill" do

    assert_difference('BillItem.count') do
      assert_difference('Bill.count') do
        Bill::generate(@ali)
      end
    end
  end
end
