class Student < ActiveRecord::Base
  belongs_to :center
  belongs_to :branch
  belongs_to :group
  has_many :bills, dependent: :destroy
  has_many :enrolls, dependent: :destroy
  has_many :quantity_fee_enrolls, -> { where("enrollable_type = 'QuantityFee'") }
  has_many :combination_fee_enrolls, -> { where("enrollable_type = 'CombinationFee'") }
  has_many :enroll_subjects, through: :enrolls
  has_many :messages, dependent: :destroy

  scope :active, -> { where(is_active: true) }

  accepts_nested_attributes_for :quantity_fee_enrolls, allow_destroy: true
  accepts_nested_attributes_for :combination_fee_enrolls, allow_destroy: true

  validates :center, presence: true
  validates :branch, presence: true, if: "branch_id.present?"
  validates :group, presence: true, if: "group_id.present?"
  validates :center_id, presence: true
  validates :ic, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_code, presence: true
  validates :phone_number, presence: true

  def full_phone_number
    phone_code + phone_number
  end
end
