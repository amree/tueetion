require 'test_helper'

class BillTest < ActiveSupport::TestCase
  setup do
    @ali = students(:ali)

    @bill = bills(:bill)
  end

  test "should not generate bill for the same month" do
    Timecop.freeze(Date.parse("2013-01-01")) do
      bill = Bill.generate(@ali)

      assert bill.invalid?
      assert bill.errors[:base].present?
    end
  end

  test "should generate bill" do
    bill = Bill.generate(@ali)

    current_month = Date.today.strftime("%m")
    current_year  = Date.today.strftime("%Y")

    assert bill.save
    assert_equal @ali.id, bill.student_id
    assert_equal @ali.center_id, bill.center_id
    assert_equal current_month, bill.month.to_s
    assert_equal current_year, bill.year.to_s
    assert_equal 2, bill.number
    assert_equal "#{current_year}#{current_month}00002", bill.real_number
    assert_equal 100, bill.total_amount
  end

  test "should be able to deactivate bill" do
    @bill.is_active = false

    assert @bill.save
  end

  test "should be able to activate deactivated bill" do
    @bill.is_active = true

    assert @bill.save
  end

  test "should be able to generate bill when there's an inactive bill available" do
    bill1 = Bill.generate(@ali)

    # Save and deactivate current month's bill
    bill1.save
    bill1.is_active = false
    bill1.save

    bill2 = Bill.generate(@ali)

    assert bill2.save
  end
end
