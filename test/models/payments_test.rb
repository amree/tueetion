require 'test_helper'

class PaymentsTest < ActiveSupport::TestCase
  setup do
    @bill = bills(:bill)
    @payment = payments(:payment)
  end

  test "payment should not be more than unpaid balance" do
    payment = Payment.new
    payment.bill_id = @payment.bill_id
    payment.amount = 900
    payment.paid_at = DateTime.now

    assert payment.invalid?
  end

  test "should mark bill as paid when all payment has been made" do
    payment = Payment.new
    payment.bill = @payment.bill
    payment.amount = 70
    payment.paid_at = DateTime.now

    assert payment.save
    assert payment.bill.is_paid

    payment.destroy
    @bill.reload

    assert !@bill.is_paid
  end
end
