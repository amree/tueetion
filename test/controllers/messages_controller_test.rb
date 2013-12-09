require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:new_message)

    sign_in users(:user)
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, message: { content: @message.content, phone_number: @message.phone_number, student_id: @message.student_id }
    end

    assert_redirected_to message_path(assigns(:message))
  end

  test "should show message" do
    get :show, id: @message

    assert_response :success
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_redirected_to messages_path
  end

  test "should update message status" do
    # TODO: Mock Twilio API request
    get :update_status, id: @message
  end
end
