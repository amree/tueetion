require 'test_helper'

class CallbacksControllerTest < ActionController::TestCase
  setup do

  end

  test "should be able to update message sid and status" do
    response = {
      :"Body" => "The body",
      :"SmsSid" => "SM5936d04d72d949dea7424b763843e354",
      :"SmsStatus" => "sent"
    }

    post :twilio, response

    message = Message.find_by_sid(response[:SmsSid])

    assert_equal response[:Body], message.sent_content
    assert_equal response[:SmsStatus], message.status
  end
end
