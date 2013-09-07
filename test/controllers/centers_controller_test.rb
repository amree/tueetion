require 'test_helper'

class CentersControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)
    @user_no_center = users(:user_no_center)
    @center = centers(:pakar)

    sign_in @user
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:centers)
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
    assert_equal @user_no_center.id, Center.last.user.id
  end

  test "should show center" do
    get :show, id: @center

    assert_response :success
    assert_equal @user.id, @center.user.id
  end

  test "should get edit" do
    get :edit, id: @center

    assert_response :success
    assert_equal @user.id, @center.user.id
  end

  test "should update center" do
    patch :update, id: @center, center: { name: @center.name }

    assert_redirected_to center_path(assigns(:center))
    assert_equal @user.id, @center.user.id
  end

  test "should destroy center" do
    assert_equal @user.id, @center.user.id

    assert_difference('Center.count', -1) do
      delete :destroy, id: @center
    end

    assert_redirected_to centers_path
  end
end
