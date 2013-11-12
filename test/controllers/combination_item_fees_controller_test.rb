require 'test_helper'

class CombinationItemFeesControllerTest < ActionController::TestCase
  setup do
    @combination_fee = combination_fees(:combo1)
    @combination_item_fee = combination_item_fees(:combo1_bi)
    @subject = subjects(:math)

    sign_in users(:user)
  end

  test "should get new" do
    get :new, { combination_fee_id: @combination_fee }

    assert_response :success
    assert_not_nil assigns(:subjects_for_select)
  end

  test "should create combination_item_fee" do
    assert_difference('CombinationItemFee.count') do

      post :create, combination_fee_id: @combination_fee, combination_item_fee: { combination_fee_id: @combination_item_fee.combination_fee_id, subject_id: @subject.id }
    end

    assert_redirected_to @combination_fee
  end

  test "should get edit" do
    get :edit, { combination_fee_id: @combination_fee, id: @combination_item_fee }

    assert_response :success
    assert_not_nil assigns(:subjects_for_select)
  end

  test "should update combination_item_fee" do
    patch :update, combination_fee_id: @combination_fee, id: @combination_item_fee, combination_item_fee: { combination_fee_id: @combination_item_fee.combination_fee_id, subject_id: @combination_item_fee.subject_id }
    assert_redirected_to @combination_fee
  end

  test "should destroy combination_item_fee" do
    assert_difference('CombinationItemFee.count', -1) do
      delete :destroy, combination_fee_id: @combination_fee, id: @combination_item_fee
    end

    assert_redirected_to @combination_fee
  end
end
