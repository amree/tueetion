class QuantityFee < ActiveRecord::Base
  belongs_to :subject
  belongs_to :center
  has_many :enrolls, as: :enrollable, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :center_id }
  validates :subject_id, presence: true
  validates :subject, presence: true
  validates :price, numericality: { greater_than: 0 }
end
