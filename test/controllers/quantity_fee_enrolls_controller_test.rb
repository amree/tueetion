require 'test_helper'

class QuantityFeeEnrollsControllerTest < ActionController::TestCase
  setup do
    @ali = students(:ali)
    @ali_quantity_fee = enrolls(:ali_quantity_fee)

    @bm_quantity_fee = quantity_fees(:bm_quantity_fee)
    @bi_quantity_fee = quantity_fees(:bi_quantity_fee)

    sign_in users(:user)
  end

  test "should get index" do
    get :index, student_id: @ali

    assert_response :success
    assert_not_nil assigns(:quantity_fee_subjects)
    assert_not_nil assigns(:student)
  end

  test "should create quantity_fee_enroll" do
    params = {
      "quantity_fee_enrolls_attributes" => {
        "321" => {
          "enrollable_id" => @bi_quantity_fee.id,
          "_destroy" => false
        }
      }
    }

    assert_difference('EnrollSubject.count') do
      assert_difference("Enroll.count") do
        post :create, student_id: @ali, student: params
      end
    end

    assert_equal Enroll.last.enrollable_type, "QuantityFee"
    assert_redirected_to student_path(@ali)
  end

  test "should be able to add quantity_fee_enroll" do
    params = {
      "quantity_fee_enrolls_attributes" => {
        "123" => {
          "id" => @ali_quantity_fee.id,
          "enrollable_id" => @bm_quantity_fee.id,
          "_destroy" => false
        },
        "321" => {
          "enrollable_id" => @bi_quantity_fee.id,
          "_destroy" => false
        }
      }
    }

    assert_difference('EnrollSubject.count') do
      assert_difference("Enroll.count") do
        post :create, student_id: @ali, student: params
      end
    end

    Enroll.where(enrollable_type: "QuantityFee").each do |enroll|
      assert_equal enroll.enroll_subjects.size, 1
    end

    assert_equal Enroll.last.enrollable_type, "QuantityFee"
    assert_redirected_to student_path(@ali)
  end

  test "should be able to delete quantity_fee_enroll" do
    params = {
      "quantity_fee_enrolls_attributes" => {
        "123" => {
          "id" => @ali_quantity_fee.id,
          "enrollable_id" => @bm_quantity_fee.id,
          "_destroy" => true
        }
      }
    }

    assert_difference('EnrollSubject.count', -1) do
      assert_difference("Enroll.count", -1) do
        post :create, student_id: @ali, student: params
      end
    end

    assert_redirected_to student_path(@ali)
  end
end
