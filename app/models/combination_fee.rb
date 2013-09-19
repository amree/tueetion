class CombinationFee < ActiveRecord::Base
  belongs_to :center
  has_many :combination_item_fees
end
