class CombinationFee < ActiveRecord::Base
  belongs_to :center
  has_many :combination_item_fees
  has_many :enrolls, as: :enrollable

  validates :center_id, presence: true
  validates :center, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :center_id }
  validates :price, numericality: { greater_than: 0 }
end
