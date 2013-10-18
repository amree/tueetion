class Bill < ActiveRecord::Base
  belongs_to :center
  belongs_to :student
  has_many :bill_items
end
