class Student < ActiveRecord::Base
  belongs_to :center
  belongs_to :branch
  belongs_to :group
  has_many :bills
  has_many :enrolls
  has_many :quantity_fee_enrolls, -> { where("enrollable_type = 'QuantityFee'") }
  has_many :combination_fee_enrolls, -> { where("enrollable_type = 'CombinationFee'") }

  accepts_nested_attributes_for :quantity_fee_enrolls, allow_destroy: true
  accepts_nested_attributes_for :combination_fee_enrolls, allow_destroy: true

  validates :center, presence: true
  validates :branch, presence: true, if: "branch_id.present?"
  validates :group, presence: true, if: "group_id.present?"
  validates :center_id, presence: true
  validates :ic, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
end
