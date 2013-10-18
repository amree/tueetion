class Student < ActiveRecord::Base
  belongs_to :center
  has_many :bills
  has_many :enrolls

  accepts_nested_attributes_for :enrolls
end
