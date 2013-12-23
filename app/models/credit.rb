class Credit < ActiveRecord::Base
  belongs_to :center
  has_many :credit_usages

  scope :available, ->(center_id) { where(center_id: center_id).where("amount > used").order(:paid_at) }
end
