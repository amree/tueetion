class Invitation < ActiveRecord::Base
  belongs_to :center

  before_validation :set_key

  validates :email, uniqueness: true

  protected

  def set_key

    self.key = generate_key
    while Invitation.find_by_key(key).present?
      self.key = generate_key
    end
  end

  def generate_key
    rand(36**10).to_s(36)
  end
end
