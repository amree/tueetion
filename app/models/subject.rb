class Subject < ActiveRecord::Base
  belongs_to :center
  has_many :quantity_fees, dependent: :destroy
  has_many :combination_item_fees, dependent: :destroy
  has_many :enroll_subjects, dependent: :destroy
  has_many :enroll, through: :enroll_subjects

  scope :by_name, -> { order(:name) }
  scope :active,  -> { where(is_active: true) }

  validates :name, presence: true
  validates :name, uniqueness: { scope: :center_id }
end
