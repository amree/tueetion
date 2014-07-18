require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @ali = students(:ali)
    @new_message = messages(:new_message)
  end

  test "phone number should not be empty" do
    message = Message.new
    message.student = @ali
    message.content = "foo bar"

    message.save

    assert_not_nil message.phone_code
    assert_not_nil message.phone_number
  end

  test "status should be new for newly created message" do
    message = @new_message.dup
    message.status = nil

    assert message.save
    assert_equal "new", message.status
  end

  test "status should not be changed to new when edited" do
    @new_message.status = "queued"

    assert @new_message.save
    assert_equal @new_message.status, "queued"
  end

  test "message should be saved with error if center is invalid" do
    message = Message.new
    message.center_id = nil

    assert message.save
    assert message.failed_messages.match 'Center is invalid'
    assert "invalid", message.status
  end

  test "message should be saved with error if student is invalid" do
    message = Message.new
    message.student_id = nil

    assert message.save
    assert message.failed_messages.match 'Student is invalid'
    assert "invalid", message.status
  end

  test "message should be saved with error if phone number is invalid" do
    message = Message.new
    message.phone_number = nil

    assert message.save
    assert message.failed_messages.match 'Phone number is invalid'
    assert "invalid", message.status
  end

  test "message should be saved with error if content is invalid" do
    message = Message.new
    message.content = nil

    assert message.save
    assert message.failed_messages.match 'Content is invalid'
    assert "invalid", message.status
  end

  test "should delete credit usages when a message was marked as failed" do
    message = messages(:processed_message)
    credit  = message.credit_usages.first.credit

    used   = credit.used
    usages = message.credit_usages.count

    message.status = 'failed'
    message.save

    message.reload
    credit.reload

    assert used - 1, credit.used
    assert_equal 0, message.credit_usages.count
  end
end
