class QuantityFeeEnrollsController < ApplicationController
  before_action :set_student

  # GET /quantity_fee_enrolls/new
  def index
    @quantity_fees = QuantityFee.joins(:subject)
                                .select("quantity_fees.id, subjects.name")
                                .to_a
  end

  # POST /quantity_fee_enrolls
  # POST /quantity_fee_enrolls.json
  def create
    @student.assign_attributes(enroll_params)

    update_student_data(@student)

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
    params.require(:student).permit(enrolls_attributes: [:enrollable_id])
  end

  def update_student_data(student)
    # For each record
    student.enrolls.each do |enroll|
      if enroll.id.nil?
        enroll.enrollable_type = "QuantityFee"
        subject_id = QuantityFee.find(enroll.enrollable_id).subject_id
        enroll.enroll_subjects.build(subject_id: subject_id)
        # debugger
        # ""
      end
    end
  end
end
