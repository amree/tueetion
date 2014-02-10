require 'test_helper'

class Public::BillsControllerTest < ActionController::TestCase
  setup do
    @ali = students(:ali)
    @bill = bills(:bill)
  end

  test "should get show" do
    get :show, student_id: @ali.public_key, id: @bill, format: :pdf

    assert_response :success
  end
end
