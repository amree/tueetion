class Credit < ActiveRecord::Base
  belongs_to :center
  has_many :credit_usages
  has_many :transactions, as: :transactable, dependent: :destroy

  accepts_nested_attributes_for :transactions

  scope :by_latest, -> { order("credits.created_at DESC") }

  after_create :increase_credit_balance

  protected

  def increase_credit_balance
    self.center.credit_balance = self.center.credit_balance + self.amount
    self.center.save
  end
end
