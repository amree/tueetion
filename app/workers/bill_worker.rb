class BillWorker
  @queue = :bill

  def self.perform(id)
    student = Student.find(id)

    if student.present?
      bill = Bill.new
      bill.student = student
      bill.center = student.center
      bill.save
    end
  end
end
