class Subject < ActiveRecord::Base
  belongs_to :center
  has_many :quantity_fees
end
