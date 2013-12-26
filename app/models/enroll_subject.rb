class EnrollSubject < ActiveRecord::Base
  belongs_to :enroll
  belongs_to :subject

  after_destroy :destroy_enroll

  protected

  def destroy_enroll
    # Delete enroll if it's the only record
    # Do not delete enroll if it has siblings, especially in CombinationFee
    if EnrollSubject.where(enroll_id: enroll_id).count == 0
      Enroll.where(id: enroll_id).first.destroy
    end
  end
end
