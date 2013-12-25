class Branch < ActiveRecord::Base
  belongs_to :center
  has_many :students, dependent: :nullify

  scope :by_name, -> { order(:name) }

  validates :name, presence: true
  validates :name, uniqueness: { scope: :center_id }
end
