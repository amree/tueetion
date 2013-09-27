class QuantityFee < ActiveRecord::Base
  belongs_to :subject
  belongs_to :center
  has_many :enrolls, as: :enrollable
end
