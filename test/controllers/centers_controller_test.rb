require 'test_helper'

class CentersControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)
    @center = centers(:pakar)

    sign_in @user
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:centers)
  end

  test "should get new" do
    Center.any_instance.stubs("owner_count").returns(0)

    get :new
    assert_response :success
  end

  test "should not get new since the user already has a center" do
    get :new

    assert_redirected_to centers_path
  end

  test "should create center" do
    Center.any_instance.stubs("owner_count").returns(0)

    assert_difference('Center.count') do
      post :create, center: { name: "New name" }
    end

    assert_redirected_to center_path(assigns(:center))
  end

  test "should show center" do
    get :show, id: @center
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @center
    assert_response :success
  end

  test "should update center" do
    patch :update, id: @center, center: { name: @center.name }
    assert_redirected_to center_path(assigns(:center))
  end

  test "should destroy center" do
    assert_difference('Center.count', -1) do
      delete :destroy, id: @center
    end

    assert_redirected_to centers_path
  end
end
