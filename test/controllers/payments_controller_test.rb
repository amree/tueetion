require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  setup do
    @bill = bills(:bill)
    @payment = payments(:payment)

    sign_in users(:user)
  end

  test "should get new" do
    get :new, bill_id: @bill

    assert_response :success
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post :create, bill_id: @bill, payment: { amount: 10, paid_at: DateTime.now }
    end

    assert Payment.last.user_id.present?
    assert_redirected_to @bill
  end

  test "should destroy payment" do
    assert_difference('Payment.count', -1) do
      delete :destroy, bill_id: @bill, id: @payment.id
    end

    assert_redirected_to @bill
  end

end
