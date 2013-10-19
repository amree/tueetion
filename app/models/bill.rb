class Bill < ActiveRecord::Base
  belongs_to :center
  belongs_to :student
  has_many :bill_items
  has_many :payments

  def self.generate(student)
    bill = Bill.new
    bill.student_id = student.id
    bill.center_id  = student.center_id
    bill.number = 1
    bill.month  = 1
    bill.year   = 2013

    total_amount = 0
    student.enrolls.each do |enroll|
      price = enroll.enrollable.price
      total_amount = total_amount + price

      bill.bill_items.new(name: "Payment for " + enroll.name, amount: price)
    end

    bill.total_amount = total_amount

    bill.save
  end
end
