require 'test_helper'

class BillTest < ActiveSupport::TestCase
  setup do
    @ali  = students(:ali)
    @amna = students(:amna)
    @bill = bills(:bill)
  end

  test "should not generate bill for the same month" do
    Timecop.freeze(Date.parse("2013-01-01")) do
      bill = Bill.new
      bill.student = @ali
      bill.center = @ali.center

      assert bill.invalid?
      assert bill.errors[:base].present?
    end
  end

  test "should generate the right full number" do
    Timecop.freeze(Date.parse("2014-01-01")) do
      bill = Bill.new
      bill.student = @ali
      bill.center = @ali.center
      bill.save

      assert_equal "20140100001", bill.full_number
    end
  end

  test "should generate bill" do
    # Mock the time since fixture has one bill in 2013
    Timecop.freeze(Time.local(2013, 7, 2, 8, 0, 0))

    bill = Bill.new
    bill.student = @ali
    bill.center = @ali.center

    current_month = Time.zone.now.strftime("%m")
    current_year  = Time.zone.now.strftime("%Y")

    assert bill.save

    # So that count_total_amount would work
    bill.reload

    assert_equal @ali.id, bill.student_id
    assert_equal @ali.center_id, bill.center_id
    assert_equal current_month.to_i.to_s, bill.month.to_s
    assert_equal current_year, bill.year.to_s
    assert_equal 2, bill.number
    assert_equal "#{current_year}#{current_month}00002", bill.full_number
    assert_equal 100, bill.total_amount

    Timecop.return
  end

  test "should be able to generate bill for other student
        in the same center in the same month" do

    # Mock the time to use the same month as the available bill
    Timecop.freeze(Time.local(2013, 1, 1, 8, 0, 0))

    bill = Bill.new
    bill.student = @amna
    bill.center = @amna.center

    assert bill.save

    Timecop.return
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
    bill1 = Bill.new
    bill1.student = @ali
    bill1.center = @ali.center

    # Save and deactivate current month's bill
    bill1.save
    bill1.is_active = false
    bill1.save

    bill2 = Bill.new
    bill2.student = @ali
    bill2.center = @ali.center

    assert bill2.save
  end

  test "should count total paid correctly" do
    assert_equal 30, @bill.total_amount_paid.to_i
  end

  test "should destroy bill items when bill destroyed" do
    @bill.destroy

    assert BillItem.where(bill_id: @bill.id).blank?
  end

  test "should destroy payments when bill destroyed" do
    @bill.destroy

    assert Payment.where(bill_id: @bill.id).blank?
  end
end
