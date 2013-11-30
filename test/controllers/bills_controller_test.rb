require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  setup do
    @bill = bills(:bill)

    sign_in users(:user)
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:bills)
  end

  test "should show bill" do
    get :show, id: @bill
    assert_response :success
  end

  test "should destroy bill" do
    assert_difference('Bill.count', -1) do
      delete :destroy, id: @bill
    end

    assert_redirected_to bills_path
  end

  test "should deactivate bill" do
    patch :deactivate, id: @bill

    @bill.reload

    assert !@bill.is_active
  end

  test "should activate bill" do
    patch :activate, id: @bill.id

    @bill.reload

    assert @bill.is_active
  end
end
