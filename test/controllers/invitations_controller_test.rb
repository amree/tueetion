require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  setup do
    @center = centers(:pakar)
    @invitation = invitations(:unused)

    sign_in users(:user)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invitation" do
    assert_difference('Invitation.count') do
      post :create, invitation: { email: "random@mail.com" }
    end

    assert_redirected_to staffs_path
  end

  test "should destroy invitation" do
    assert_difference('Invitation.count', -1) do
      delete :destroy, id: @invitation
    end

    assert_redirected_to invitations_path
  end

  test "should get reinvite" do
    get :reinvite, id: @invitation

    assert_redirected_to invitations_path
  end
end
