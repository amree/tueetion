class BillWorker
  @queue = :bill

  def self.perform(id)
    student = Student.find(id)

    if student.present?
      Bill.generate(student).save
    end
  end
end
