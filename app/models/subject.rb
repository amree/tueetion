class Subject < ActiveRecord::Base
  belongs_to :center
  has_many :quantity_fees

  scope :by_name, -> { order(:name) }
  scope :active,  -> { where(is_active: true) }

  validates :name, uniqueness: { scope: :center_id }
end
