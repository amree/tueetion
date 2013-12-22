require 'bill_calculator'

class MessageProcessor
  attr_reader :content

  def initialize(message)
    @student = message.student
    @content = message.content

    set_first_name
    set_last_name
    set_unpaid_amount
    set_unpaid_bill_count
    calculate_size
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

  def calculate_size
    @length = @content.length
    @size   = (@length / 60.0).ceil
  end
end
