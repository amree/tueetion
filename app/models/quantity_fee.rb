class QuantityFee < ActiveRecord::Base
  belongs_to :subject
  belongs_to :center
end
