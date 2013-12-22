class BillCalculator
  def initialize(student)
    @student = student
  end

  def get_unpaid_amount
    total_unpaid_amount = 0

    Bill.where(student_id: @student.id).each do |bill|
      unless bill.is_paid
        total_unpaid_amount = total_unpaid_amount + bill.payments.sum(:amount)
      end
    end

    total_unpaid_amount
  end

  def get_unpaid_bill_count
    Bill.where(student_id: @student.id, is_paid: false).count
  end
end
