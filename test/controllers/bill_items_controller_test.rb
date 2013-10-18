require 'test_helper'

class BillItemsControllerTest < ActionController::TestCase
  setup do
    @bill = bills(:bill)
    @bill_item = bill_items(:bill_item)

    sign_in users(:user)
  end

  test "should get new" do
    get :new, bill_id: @bill
    assert_response :success
  end

  test "should create bill_item" do
    assert_difference('BillItem.count') do
      post :create, bill_id: @bill, bill_item: { amount: @bill_item.amount, name: @bill_item.name }
    end

    # assert_redirected_to bill_item_path(assigns(:bill_item))
    assert_redirected_to @bill
  end

  test "should show bill_item" do
    get :show, bill_id: @bill, id: @bill_item

    assert_response :success
  end

  test "should get edit" do
    get :edit, { bill_id: @bill, id: @bill_item }

    assert_response :success
  end

  test "should update bill_item" do
    patch :update, bill_id: @bill, id: @bill_item, bill_item: { amount: @bill_item.amount, name: @bill_item.name }

    assert_redirected_to @bill
  end

  test "should destroy bill_item" do
    assert_difference('BillItem.count', -1) do
      delete :destroy, bill_id: @bill, id: @bill_item
    end

    assert_redirected_to @bill
  end
end
