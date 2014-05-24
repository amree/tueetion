class Center < ActiveRecord::Base
  has_many :users

  has_many :bills
  has_many :branches
  has_many :credits
  has_many :messages
  has_many :students
  has_many :subjects
  has_many :quantity_fees
  has_many :combination_fees
  has_many :invitations
  has_many :groups
  has_many :subscriptions
  has_many :credits
  has_one  :option

  validates :name, presence: true
  validates :name, uniqueness: true
end
