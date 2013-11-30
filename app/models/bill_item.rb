class BillItem < ActiveRecord::Base
  belongs_to :bill

  validate :must_not_be_paid, unless: "self.new_record?"

  after_save :ask_bill_to_recalculate

  protected

  def must_not_be_paid
    if self.bill.is_paid
      errors.add(:base, "Only unpaid bill can be modified.")
    end
  end

  def ask_bill_to_recalculate
    bill = self.bill
    bill.count_total_amount
    bill.save
  end
end
