class Credit < ActiveRecord::Base
  belongs_to :center
  has_many :credit_usages
  has_many :transactions, as: :transactable, dependent: :destroy

  accepts_nested_attributes_for :transactions

  scope :available, -> { where("amount > used") }
  scope :by_latest, -> { order("credits.created_at DESC") }
end
