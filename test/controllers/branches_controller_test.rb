require 'test_helper'

class BranchesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:user)

    @center = centers(:pakar)
    @branch = branches(:kb)
  end

  test "should get new" do
    get :new, center_id: @center

    assert_response :success
  end

  test "should create branch" do
    assert_difference('Branch.count') do
      post :create, center_id: @center, branch: { name: @branch.name }
    end

    assert_redirected_to @center
  end

  test "should get edit" do
    get :edit, center_id: @center, id: @branch

    assert_response :success
  end

  test "should update branch" do
    patch :update, center_id: @center, id: @branch, branch: { name: @branch.name }

    assert_redirected_to @center
  end

  # test "should destroy branch" do
  #   assert_difference('Branch.count', -1) do
  #     delete :destroy, id: @branch
  #   end

  #   assert_redirected_to branches_path
  # end
end
