class CombinationItemFee < ActiveRecord::Base
  belongs_to :combination_fee
  belongs_to :subject

  validates :subject, presence: true
  validates :subject_id, uniqueness: { scope: :combination_fee_id }
  validates :combination_fee, presence: true

  after_destroy :destroy_enroll_subjects

  protected

  def destroy_enroll_subjects
    EnrollSubject.where(subject_id: subject_id).joins(:enroll).where(enrolls: {enrollable_id: combination_fee_id}).readonly(false).each do |enroll_subject|
      enroll_subject.destroy!
    end
  end
end
