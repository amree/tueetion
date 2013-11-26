class CombinationFeeEnrollSubjectsController < ApplicationController
  before_action :set_student
  before_action :set_combination_fee_enroll

  # GET /students/:student_id/combination_fee_enroll_subjects/:id/edit
  def edit
  end

  # PUT /students/:student_id/combination_fee_enroll_subjects/:id
  def update
    if @combination_fee_enroll.update(enroll_subject_params)
      redirect_to @student, notice: 'Subjects has been successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def set_student
    @student = current_center.students.find(params[:student_id])
  end

  def set_combination_fee_enroll
    @combination_fee_enroll = @student.combination_fee_enrolls.find(params[:id])
  end

  def enroll_subject_params
    params.require(:combination_fee_enroll).permit(subject_ids: [])
  end
end
