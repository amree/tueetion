class QuantityFeeEnrollsController < ApplicationController
  before_action :set_student

  # GET /quantity_fee_enrolls/new
  def index
    if @student.enrolls.size == 0
      @student.enrolls.build
    end
  end

  # POST /quantity_fee_enrolls
  # POST /quantity_fee_enrolls.json
  def create
    respond_to do |format|
      if @student.update(enroll_params)
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
    params.require(:student).permit(enrolls_attributes: [:enrollable_id, :enrollable_type])
  end
end
