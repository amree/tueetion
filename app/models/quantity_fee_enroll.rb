class QuantityFeeEnroll < Enroll
  validates :enrollable_id, uniqueness: { scope: [:student_id, :enrollable_type] }

  before_validation :set_enrollable_type
  validates :enrollable, presence: true
  validate  :enrollable_should_be_from_same_center
  after_save :generate_enrolled_subjects

  def name
    enrollable.subject.name
  end

  def enrollable_should_be_from_same_center
    unless self.enrollable.nil?
      student_center_id = self.student.center.id
      quantity_fee_center_id = self.enrollable.center.id

      if student_center_id != quantity_fee_center_id
        errors.add(:enrollable, "must be from the same center")
      end
    end
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
