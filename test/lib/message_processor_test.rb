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
  end
end
