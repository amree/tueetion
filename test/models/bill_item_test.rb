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

  test "should update Bill's total amount when changed" do
    @bill_item.amount = 100
    @bill_item.save

    assert 150, @bill_item.bill.total_amount.to_int
  end
end
