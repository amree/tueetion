class BillItem < ActiveRecord::Base
  belongs_to :bill

  validate :must_not_be_paid, unless: "self.new_record?"

  protected

  def must_not_be_paid
    if self.bill.is_paid
      errors.add(:base, "Only unpaid bill can be modified.")
    end
  end
end
