class Enroll < ActiveRecord::Base
  belongs_to :student
  belongs_to :enrollable, polymorphic: true
  has_many :enroll_subjects, dependent: :destroy
  has_many :subjects, through: :enroll_subjects

  accepts_nested_attributes_for :enroll_subjects

  validates :enrollable_id, uniqueness: { scope: :student_id }, if: "enrollable_type == 'QuantityFee'"


  def name
    if enrollable_type == "QuantityFee"
      enrollable.subject.name
    elsif enrollable_type == "CombinationFee"
      enrollable.name
    end
  end
end
