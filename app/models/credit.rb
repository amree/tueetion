class Credit < ActiveRecord::Base
  belongs_to :center

  scope :available, ->(center_id) { where(center_id: center_id).where("amount > used").order(:paid_at) }
end
