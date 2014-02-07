class User < ActiveRecord::Base
  belongs_to :center

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

  def is_admin?
    access_level == 100
  end

  def is_owner?
    access_level == 50
  end

  def is_staff?
    access_level == 10
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
