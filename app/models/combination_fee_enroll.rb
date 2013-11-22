class CombinationFeeEnroll < Enroll
  before_validation :set_enrollable_type
  after_save :generate_enrolled_subjects

  def name
    enrollable.name
  end

  protected

  def set_enrollable_type
    self.enrollable_type = "CombinationFee"
  end

  # TODO: Service Object?
  def generate_enrolled_subjects
    self.enrollable.subjects.each do |subject|
      enroll_subject = self.enroll_subjects.find_or_initialize_by(subject: subject)
      enroll_subject.save!
    end
  end
end
