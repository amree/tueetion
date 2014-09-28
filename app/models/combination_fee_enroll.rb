class CombinationFeeEnroll < Enroll
  validates :student_id, uniqueness: { scope: [:enrollable_id, :enrollable_type] }

  before_validation :set_enrollable_type
  validates :enrollable, presence: true
  validate  :enrollable_should_be_from_same_center
  after_create :generate_enrolled_subjects
  after_update :regenerate_enrolled_subjects, if: "self.enrollable_id_changed?"

  def name
    enrollable.name
  end

  def enrollable_should_be_from_same_center
    unless self.enrollable.nil?
      student_center_id = self.student.center.id
      enroll_fee_center_id = self.enrollable.center.id

      if student_center_id != enroll_fee_center_id
        errors.add(:enrollable, "must be from the same center")
      end
    end
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

  # TODO: Service Object?
  def regenerate_enrolled_subjects
    subject_ids = self.enrollable.subject_ids

    # Create new Enroll Subject if not exits
    subject_ids.each do |subject|
      enroll_subject = self.enroll_subjects.find_or_initialize_by(subject_id: subject)
      enroll_subject.save!
    end

    # Delete old Enroll Subject if it's not from the Combination Fee
    difference = self.subject_ids - subject_ids

    difference.each do |subject|
      enroll_subject = self.enroll_subjects.find_by(subject_id: subject)
      enroll_subject.destroy
    end
  end
end
