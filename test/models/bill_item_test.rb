require 'test_helper'

class BillItemTest < ActiveSupport::TestCase
  setup do
    @bill_item = bill_items(:bill_item)
  end

  test "should not be able to edit if it's paid" do
    # Mock so that bill is marked as paid
    Bill.any_instance.stubs(:is_paid).returns(true)

    bill = @bill_item.bill
    @bill_item.amount = 100

    assert @bill_item.invalid?
    assert @bill_item.errors[:base].present?
  end
end
