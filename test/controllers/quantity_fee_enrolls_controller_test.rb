require 'test_helper'

class QuantityFeeEnrollsControllerTest < ActionController::TestCase
  setup do
    @ali = students(:ali)
    @bm_quantity_fee = quantity_fees(:bm_quantity_fee)
    @bi_quantity_fee = quantity_fees(:bi_quantity_fee)

    sign_in users(:user)
  end

  test "should get index" do
    get :index, student_id: @ali

    assert_response :success
    assert_not_nil assigns(:student)
  end

  test "should update quantity_fee_enroll" do
    params = {
      enrolls_attributes: [
        { enrollable_id: @bm_quantity_fee.id, enrollable_type: "QuantityFee" },
        { enrollable_id: @bi_quantity_fee.id, enrollable_type: "QuantityFee" }
      ]
    }

    assert_difference('Enroll.count', 2) do
      post :create, student_id: @ali, student: params
    end

    assert_redirected_to student_path(@ali)
  end
end
