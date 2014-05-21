class Payment < ActiveRecord::Base
  belongs_to :bill

  validates :paid_at, presence: true
  validates :amount, presence: true
  validates :amount, numericality: true

  validate :less_than_bill_balance, if: "amount.present? && amount >= 0"
  validate :paid_at_should_not_be_from_the_future, if: "paid_at.present?"

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

  def paid_at_should_not_be_from_the_future
    if DateTime.now < self.paid_at
      errors.add(:paid_at, "Should not be from the future")
    end
  end
end
