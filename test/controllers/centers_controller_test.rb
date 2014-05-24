require 'test_helper'

class CentersControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)
    @user_no_center = users(:user_no_center)
    @center = centers(:pakar)

    sign_in @user
  end

  test "should get new" do
    sign_out @user
    sign_in  users(:user_no_center)

    get :new

    assert_response :success
  end

  test "should not get new since the user already has a center" do
    get :new

    assert_redirected_to centers_path
  end

  test "should create center" do
    sign_out @user
    sign_in  @user_no_center

    assert_difference('Center.count') do
      post :create, center: { name: "New name" }
    end

    assert_redirected_to center_path(assigns(:center))
    assert_equal Center.last.id, User.find(@user_no_center.id).center_id
  end

  test "should show center" do
    get :show, id: @center

    assert_response :success
    assert_equal @center.id, @user.center_id
  end

  test "should get edit" do
    get :edit, id: @center

    assert_response :success
    assert_equal @center.id, @user.center_id
  end

  test "should update center" do
    patch :update, id: @center, center: { name: @center.name }

    assert_redirected_to center_path(assigns(:center))
    assert_equal @center.id, @user.center_id
  end

  test "should destroy center" do
    assert_difference('Center.count', -1) do
      delete :destroy, id: @center
    end

    assert_redirected_to centers_path
  end

  test "should get bulks" do
    get :bulks

    assert_response :success
  end

  test "should get bulk_create_bills" do
    get :create_bills

    assert_redirected_to bulks_centers_path
  end
end
