class Center < ActiveRecord::Base
  belongs_to :user
  has_many :bills
  has_many :branches
  has_many :students
  has_many :subjects
  has_many :quantity_fees
  has_many :combination_fees

  validates :user, :name, presence: true
  validates :name, uniqueness: true

  validate :verify_owner_count, on: :create

  def owner_count
    Center.where("user_id = ?", self.user_id).count
  end

  protected

  def verify_owner_count
    if owner_count > 0
      errors.add(:name, "A user can have only one center")
    end
  end
end
