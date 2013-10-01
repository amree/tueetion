class Enroll < ActiveRecord::Base
  belongs_to :student
  belongs_to :enrollable, polymorphic: true
  has_many :student_subjects

  validate :verify_center, if: "self.enrollable_type == 'QuantityFee'"

  after_save :create_or_update_subject, if: "self.enrollable_type == 'QuantityFee'"

  private

  def verify_center
    if enrollable.center_id != student.center_id
      errors.add(:base, "Unknown Quantity Fee")
    end
  end

  def create_or_update_subject
    subject = student_subjects.where(subject_id: enrollable.subject.id).first

    unless subject
      StudentSubject.create!(enroll_id: self.id,
                             subject_id: self.enrollable.subject.id)
    end
  end
end
