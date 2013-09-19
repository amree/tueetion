class CombinationItemFee < ActiveRecord::Base
  belongs_to :combination_fee
  belongs_to :subject
end
