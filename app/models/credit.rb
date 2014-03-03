class Credit < ActiveRecord::Base
  belongs_to :center
  has_many :credit_usages

  scope :available, -> { where("amount > used") }
  scope :by_latest, -> { order("credits.created_at DESC") }
end
