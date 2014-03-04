class Subscription < ActiveRecord::Base
  belongs_to :center
  has_many :transactions, as: :transactable, dependent: :destroy

  accepts_nested_attributes_for :transactions
end
