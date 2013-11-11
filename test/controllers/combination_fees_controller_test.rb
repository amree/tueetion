require 'test_helper'

class CombinationFeesControllerTest < ActionController::TestCase
  setup do
    @combination_fee = combination_fees(:combo1)

    sign_in users(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:combination_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create combination_fee" do
    assert_difference('CombinationFee.count') do
      post :create, combination_fee: { center_id: @combination_fee.center_id, is_active: @combination_fee.is_active, name: @combination_fee.name, price: @combination_fee.price }
    end

    assert_redirected_to combination_fee_path(assigns(:combination_fee))
  end

  test "should show combination_fee" do
    get :show, id: @combination_fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @combination_fee
    assert_response :success
  end

  test "should update combination_fee" do
    patch :update, id: @combination_fee, combination_fee: { center_id: @combination_fee.center_id, is_active: @combination_fee.is_active, name: @combination_fee.name, price: @combination_fee.price }
    assert_redirected_to combination_fee_path(assigns(:combination_fee))
  end

  test "should destroy combination_fee" do
    assert_difference('CombinationFee.count', -1) do
      delete :destroy, id: @combination_fee
    end

    assert_redirected_to combination_fees_path
  end
end
