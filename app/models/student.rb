class Student < ActiveRecord::Base
  belongs_to :center
  has_many :bills
  has_many :enrolls

  accepts_nested_attributes_for :enrolls

  validates :center, presence: true
  validates :center_id, presence: true
  validates :ic, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
end
