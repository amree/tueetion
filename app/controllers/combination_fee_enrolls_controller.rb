class CombinationFeeEnrollsController < ApplicationController
  before_action :set_student

  def index
    # For CombinationFee select box selection
    @combination_fees = current_center.combination_fees.to_a

    # For CombinationFee's subject list
    # TODO: AJAX
    @combination_item_fees = CombinationFee.first.combination_item_fees
  end

  def create
    @student.assign_attributes(enroll_params)
    # Manually set
    @student.enrolls.last.enrollable_type = "CombinationFee"

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully updated with the selected subjects.' }
        format.json { render action: 'show', status: :created, location: @student }
      else
        debugger
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
