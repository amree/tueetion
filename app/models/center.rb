class Center < ActiveRecord::Base
  has_many :users

  has_many :bills
  has_many :branches
  has_many :students
  has_many :subjects
  has_many :quantity_fees
  has_many :combination_fees

  validates :name, presence: true
  validates :name, uniqueness: true
end
