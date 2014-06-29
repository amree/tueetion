require 'test_helper'
require 'message_processor'

class MessageProcessorTest < ActiveSupport::TestCase
  setup do
    @message = messages(:new_message)
  end

  test "should parse new message correctly" do
    mp = MessageProcessor.new(@message)

    text = "Muhammad Ali Muhammad Hassan 30.00 1"

    assert_equal text, mp.content
    assert_equal text.length, mp.content_length
    assert_equal 1, mp.sms_count
    assert_equal 0.027, mp.price
  end

  # TODO: Test when all credit used
  # TODO: Test when no credit has been bought
end
