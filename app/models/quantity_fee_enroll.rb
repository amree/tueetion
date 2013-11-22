class QuantityFeeEnroll < Enroll
  before_validation :set_enrollable_type
  after_save :generate_enrolled_subjects

  def name
    enrollable.subject.name
  end

  protected

  def set_enrollable_type
    self.enrollable_type = "QuantityFee"
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
