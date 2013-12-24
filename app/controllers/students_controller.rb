class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :generate_bill]
  before_action :set_branches, only: [:new, :create, :edit, :update]
  before_action :set_groups, only: [:new, :create, :edit, :update]

  # GET /students
  # GET /students.json
  def index

    if params[:q]
      q = "%#{params[:q]}%"
      @students = current_center.students.where("first_name like ? or last_name like ? or ic like ?", q, q, q).to_a
    else
      @students = current_center.students.to_a
    end
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
    bill = Bill.generate(@student)

    if bill.save
      redirect_to @student, notice: 'Bill was successfully generated.'
    else
      redirect_to @student, alert: 'Bill failed to be generated. Reasons: ' + bill.errors.messages[:base].join(",")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = current_center.students.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:branch_id, :group_id, :ic, :first_name, :last_name, :dob, :email, :phone, :school_name, :is_active)
  end

  def set_branches
    @branches = Branch.by_name.to_a.collect { |b| [b.name, b.id] }
  end

  def set_groups
    @groups = Group.by_name.collect { |g| [g.name, g.id] }
  end
end

