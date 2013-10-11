class CombinationFeeEnrollsController < ApplicationController
  before_action :set_student

  def index
    @combination_fees = current_center.combination_fees.to_a
    # # FIXME
    # @combination_item_fees = CombinationFee.first.combination_item_fees
    @combination_item_fees = CombinationFee.first.combination_item_fees
    @student.enrolls.new
    @student.enrolls.first.enroll_subjects.new
  end

  def create
    # Manually set
    @student.assign_attributes(enroll_params)
    @student.enrolls.last.enrollable_type = "CombinationFee"

    debugger

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully updated with the selected subjects.' }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_student
    @student = current_center.students.find(params[:student_id])
  end

  def enroll_params
    enroll_subjects_params = { :enroll_subjects_attributes => [:subject_id]}
    params.require(:student).permit(enrolls_attributes: [:enrollable_id, enroll_subjects_params])
  end
end
