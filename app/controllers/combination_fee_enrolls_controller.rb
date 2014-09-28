class CombinationFeeEnrollsController < ApplicationController
  before_action :set_student
  before_action :set_combination_fees

  def index
    if current_center.combination_fees.blank?
      redirect_to combination_fees_path, alert: 'You need to setup your Combination/Package Fees before proceeding.'
    end

    unless @student.combination_fee_enrolls.size > 0
      @student.combination_fee_enrolls.build
    end
  end

  def create
    @student.assign_attributes(enroll_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully updated with the selected subjects.' }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'index' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def enroll_params
    params.require(:student).permit(combination_fee_enrolls_attributes: [:id, :enrollable_id, :_destroy])
  end

  def set_student
    @student = current_center.students.find(params[:student_id])
  end

  def set_combination_fees
    @combination_fees = current_center.combination_fees.to_a.collect { |c| [c.name, c.id] }
  end
end
