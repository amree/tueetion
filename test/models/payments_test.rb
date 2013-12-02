require 'test_helper'

class PaymentsTest < ActiveSupport::TestCase
  setup do
    @payment = payments(:payment)
  end

  test "payment should not be more than unpaid balance" do
    payment = Payment.new
    payment.bill_id = @payment.bill_id
    payment.amount = 900
    payment.paid_at = DateTime.now

    assert payment.invalid?
  end
end
