class Branch < ActiveRecord::Base
  belongs_to :center

  validates :name, presence: true
  validates :name, uniqueness: { scope: :center_id }
end
