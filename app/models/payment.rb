class Payment < ActiveRecord::Base
  belongs_to :bill

  validate :less_than_bill_balance

  after_create  :update_bill_paid_status
  after_destroy :update_bill_paid_status

  protected

  def less_than_bill_balance
    if self.amount > (self.bill.total_amount - self.bill.total_amount_paid)
      errors.add(:amount, "The amount should not be more than the bill's balance")
    end
  end

  def update_bill_paid_status
    if self.bill.total_amount_paid == self.bill.total_amount
      self.bill.is_paid = true
      self.bill.save
    else
      self.bill.is_paid = false
      self.bill.save
    end
  end
end
