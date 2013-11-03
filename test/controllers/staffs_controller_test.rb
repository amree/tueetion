require 'test_helper'

class StaffsControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)

    sign_in users(:user)
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should lock staff" do
    patch :lock, id: @user

    @user.reload

    assert !@user.is_active
    assert_redirected_to staffs_url
  end

  test "should unlock staff" do
    patch :unlock, id: @user

    @user.reload

    assert @user.is_active
    assert_redirected_to staffs_url
  end
end
