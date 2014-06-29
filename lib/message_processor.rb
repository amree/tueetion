require 'bill_calculator'

# You can get:
# @content : Parsed content
# @content_length  : Message's character length
# @sms_count   : How much SMS's credit needed
class MessageProcessor
  attr_reader :content
  attr_reader :content_length
  attr_reader :sms_count
  attr_reader :price

  def initialize(message)
    @message = message
    @student = @message.student
    @content = @message.content

    set_first_name
    set_last_name
    set_unpaid_amount
    set_unpaid_bill_count
    calculate_size
    set_price
  end

  private

  def set_first_name
    @content.gsub! /{{first_name}}/,
                   (@student.first_name || "?")
  end

  def set_last_name
    @content.gsub! /{{last_name}}/,
                   (@student.last_name || "?")
  end

  def set_unpaid_amount
    amount = sprintf("%0.02f", BillCalculator.new(@student).get_unpaid_amount)

    @content.gsub! /{{unpaid_amount}}/,
                   (amount || "0")
  end

  def set_unpaid_bill_count
    @content.gsub! /{{unpaid_bill_count}}/,
                   (BillCalculator.new(@student).get_unpaid_bill_count.to_s || "0")
  end

  def set_price
    @price = Country.find_by_calling_code(@message.phone_code).try(:sms_rate) || 0.1
  end

  def calculate_size
    @content_length = @content.length
    @sms_count   = (@content_length / 60.0).ceil
  end
end
