class CreditUsage < ActiveRecord::Base
  belongs_to :message
  belongs_to :credit

  after_create  :deduct_credit_usage
  after_destroy :increase_credit_usage

  protected

  def deduct_credit_usage
    self.credit.used += 1
    self.credit.save
  end

  def increase_credit_usage
    self.credit.used -= 1
    self.credit.save
  end
end
