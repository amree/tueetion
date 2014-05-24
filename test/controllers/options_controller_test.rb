require 'test_helper'

class OptionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:user)
    @option = options(:pakar)

    sign_in @user
  end

  test "should get edit" do
    get :edit, id: @option

    assert_response :success
  end

  test "should update option" do
    patch :update, id: @option, option: { time_zone: @option.time_zone }

    assert_redirected_to edit_option_path(assigns(:option))
  end
end
