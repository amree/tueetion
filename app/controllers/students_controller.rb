class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :generate_bill]

  # GET /students
  # GET /students.json
  def index
    @students = current_center.students.to_a
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @payments = Payment.joins(bill: :student).where("students.id = ?", @student.id)
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = current_center.students.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  # POST /students/1/generate_bill
  def generate_bill
    if Bill::generate(@student)
      redirect_to @student, notice: 'Bill was successfully generated.'
    else
      redirect_to @student, alert: 'Bill failed to be generated.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = current_center.students.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:ic, :first_name, :last_name, :dob, :email, :phone, :school_name, :is_active)
  end
end
