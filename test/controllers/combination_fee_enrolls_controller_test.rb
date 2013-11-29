require 'test_helper'

class CombinationFeeEnrollsControllerTest < ActionController::TestCase
  setup do
    @ali = students(:ali)

    @combo1 = combination_fees(:combo1)
    @combo2 = combination_fees(:combo2)

    @math = subjects(:math)

    @ali_combination_fee = enrolls(:ali_combination_fee)

    sign_in users(:user)
  end

  test "should get index" do
    get :index, student_id: @ali

    assert_response :success
    assert_not_nil assigns(:student)
  end

  test "should insert new combination fee package to the student" do
    rand = Time.now.object_id.to_s

    params = {
      "combination_fee_enrolls_attributes" => {
        rand => {
          "enrollable_id" => @combo2.id,
          "_destroy" => false
        }
      }
    }

    assert_difference('Enroll.count') do
      assert_difference('EnrollSubject.count') do
        post :create, student_id: @ali, student: params
      end
    end

    assert_equal Enroll.last.enrollable_type, "CombinationFee"
    assert_redirected_to student_path(@ali)
  end

  test "should change enroll subjects if combination fee changed" do
    rand = Time.now.object_id.to_s

    params = {
      "combination_fee_enrolls_attributes" => {
        rand => {
          "enrollable_id" => @combo2.id,
          "_destroy" => false,
          "id" => @ali_combination_fee.id
        }
      }
    }

    assert_difference('Enroll.count', 0) do
      assert_difference('EnrollSubject.count') do
        post :create, student_id: @ali, student: params
      end
    end

    assert_equal 1, Enroll.where(enrollable_type: "CombinationFee").first.enroll_subjects.size
    assert_equal @math, Enroll.last.enroll_subjects.where(subject_id: @math.id).first.subject

    assert_redirected_to student_path(@ali)
  end
end
