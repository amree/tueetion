class CombinationItemFee < ActiveRecord::Base
  belongs_to :combination_fee
  belongs_to :subject

  validates :subject, presence: true
  validates :subject_id, uniqueness: { scope: :combination_fee_id }
  validates :combination_fee, presence: true
end
