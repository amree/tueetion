require 'test_helper'

class Public::StudentsControllerTest < ActionController::TestCase
  setup do
    @ali = students(:ali)
  end

  test "should get show" do
    get :show, id: @ali.public_key

    assert_response :success
    assert assigns(:student)
  end
end
