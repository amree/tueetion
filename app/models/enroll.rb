class Enroll < ActiveRecord::Base
  belongs_to :student
  belongs_to :enrollable, polymorphic: true
  has_many :enroll_subjects
  has_many :subjects, through: :enroll_subjects

  accepts_nested_attributes_for :enroll_subjects

  after_save :generate_enrolled_subjects

  def name
    if enrollable_type == "QuantityFee"
      enrollable.subject.name
    elsif enrollable_type == "CombinationFee"
      enrollable.name
    end
  end

  # TODO: Service Object?
  def generate_enrolled_subjects
    if enrollable_type == "QuantityFee"
      enroll_subject = EnrollSubject.find_or_initialize_by(enroll_id: self.id)
      enroll_subject.subject_id = self.enrollable.subject_id
      enroll_subject.save
    end
  end
end
