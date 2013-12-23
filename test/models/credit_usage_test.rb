require 'test_helper'

class CreditUsageTest < ActiveSupport::TestCase
  setup do
    @processed_message = messages(:processed_message)
    @credit = credits(:credit_pakar)

    @usage = credit_usages(:sent_message_usage)
  end

  test "newly created credit should deduct from credit" do
    original_usage = @credit.used

    count = Array.new((@processed_message.processed_content.length / 60.0).ceil)
    count.each do |x|
      usage = CreditUsage.new(message_id: @processed_message.id, credit_id: @credit.id)
      usage.save
    end

    @credit.reload
    assert_equal original_usage + count.size, @credit.used
  end

  test "destroyed credit usage should decrease the used count" do
    used = @usage.credit.used

    @usage.destroy

    assert_equal used - 1, @usage.credit.used
  end
end
