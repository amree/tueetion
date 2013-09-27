class CombinationFee < ActiveRecord::Base
  belongs_to :center
  has_many :combination_item_fees
  has_many :enrolls, as: :enrollable
end
