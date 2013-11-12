class Group < ActiveRecord::Base
  belongs_to :center
  has_many :students

  scope :by_name, -> { order(:name) }

  validates :name, presence: true
  validates :name, uniqueness: { scope: :center_id }
end
