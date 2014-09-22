class User < ActiveRecord::Base
  belongs_to :center
  has_many :bills

  scope :active, -> { where(is_active: true) }

  attr_accessor :key

  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :center, presence: true, if: "center_id.present?"

  before_validation :set_staff_values, if: "key.present?"
  after_create :mark_invitation_used, if: "key.present?"

  ADMIN_LEVEL = 100
  OWNER_LEVEL = 50
  STAFF_LEVEL = 10

  def is_admin?
    access_level == ADMIN_LEVEL
  end

  def is_owner?
    access_level == OWNER_LEVEL
  end

  def is_staff?
    access_level == STAFF_LEVEL
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  protected

  def set_staff_values
    invitation = Invitation.where(key: key, is_used: false).try(:first)

    if invitation
      self.center_id = invitation.center_id
      self.access_level = 10
      self.email = invitation.email
    else
      errors.add(:base, "Invalid invitation.")
    end
  end

  # TODO: Extract as service object?
  def mark_invitation_used
    invitation = Invitation.where(key: key, is_used: false).try(:first)
    invitation.is_used = true

    invitation.save
  end
end
