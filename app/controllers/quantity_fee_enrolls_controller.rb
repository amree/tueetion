class QuantityFeeEnrollsController < ApplicationController
  before_action :set_student
  before_action :set_quantity_fee_subjects

  # GET /quantity_fee_enrolls/new
  def index
    if current_center.quantity_fees.blank?
      redirect_to quantity_fees_path, alert: 'You need to setup your Quantity Fees based Fee before proceeding.'
    end

    if @student.quantity_fee_enrolls.size == 0
      @student.quantity_fee_enrolls.build
    end
  end

  # POST /quantity_fee_enrolls
  # POST /quantity_fee_enrolls.json
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

  def set_student
    @student = current_center.students.find(params[:student_id])
  end

  def enroll_params
    params.require(:student).permit(quantity_fee_enrolls_attributes: [:id, :enrollable_id, :_destroy])
  end

  def set_quantity_fee_subjects
    @quantity_fee_subjects = current_center
                              .quantity_fees
                              .joins(:subject)
                              .select("quantity_fees.id, subjects.name")
                              .order(:name)
                              .to_a
                              .collect { |q| [q.name, q.id] }
  end
end

