class User < ActiveRecord::Base
  belongs_to :center

  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :center, presence: true, if: "center_id.present?"

  def is_admin
    access_level == 100
  end
end
