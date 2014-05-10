require 'test_helper'

class Admin::CentersControllerTest < ActionController::TestCase
  setup do
    @admin = users(:admin)
    @center = centers(:pakar)

    sign_in @admin
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:centers)
  end

  test "should show center" do
    get :show, id: @center

    assert_response :success
  end
end
