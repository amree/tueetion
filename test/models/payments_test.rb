require 'test_helper'

class PaymentsTest < ActiveSupport::TestCase
  setup do
    @bill = bills(:bill)
    @payment = payments(:payment)

    @valid_data = {
      bill: @payment.bill,
      amount: 70,
      paid_at: DateTime.now
    }
  end

  test "payment should not be more than unpaid balance" do
    payment = Payment.new
    payment.bill_id = @payment.bill_id
    payment.amount = 900
    payment.paid_at = DateTime.now

    assert payment.invalid?
    assert payment.errors[:amount].present?
  end

  test "should mark bill as paid when all payment has been made" do
    payment = Payment.new(@valid_data)

    assert payment.save
    assert payment.bill.is_paid

    payment.destroy
    @bill.reload

    assert !@bill.is_paid
  end

  test "paid_at should be present" do
    payment = Payment.new(@valid_data)
    payment.paid_at = nil

    assert payment.invalid?
    assert payment.errors[:paid_at].present?
  end

  test "paid_at should not be from the future" do
    payment = Payment.new(@valid_data)
    payment.paid_at = Time.now + 1

    assert payment.invalid?
    assert payment.errors[:paid_at].present?
  end

  test "amount should be valid" do
    payment = Payment.new(@valid_data)
    payment.amount = 'foo'

    assert payment.invalid?
    assert payment.errors[:amount].present?
  end

  test "amount should not be nil" do
    payment = Payment.new(@valid_data)
    payment.amount = nil

    assert payment.invalid?
    assert payment.errors[:amount].present?
  end
end
