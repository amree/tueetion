class Payment < ActiveRecord::Base
  belongs_to :bill

  validate :less_than_bill_balance

  protected

  def less_than_bill_balance
    if self.amount > self.bill.payments.sum(:amount)
      errors.add(:amount, "The amount should not be more than the bill's balance")
    end
  end
end
