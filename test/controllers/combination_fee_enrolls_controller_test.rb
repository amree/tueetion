require 'test_helper'

class CombinationFeeEnrollsControllerTest < ActionController::TestCase
  setup do
    @ali = students(:ali)

    @combo1 = combination_fees(:combo1)
    @bm = subjects(:bm)
    @bi = subjects(:bi)

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
          "enrollable_id" => @combo1.id
        }
      }
    }

    assert_difference('Enroll.count') do
      assert_difference('EnrollSubject.count', 2) do
        post :create, student_id: @ali, student: params
      end
    end

    assert_equal Enroll.last.enrollable_type, "CombinationFee"
    assert_redirected_to student_path(@ali)
  end
end
