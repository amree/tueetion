class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :create_bill]
  before_action :set_branches, only: [:new, :create, :edit, :update]
  before_action :set_groups, only: [:new, :create, :edit, :update]
  before_action :set_group_selections, only: [:index]
  before_action :set_branch_selections, only: [:index]
  before_action :set_enrollable_type_selections, only: [:index]
  before_action :set_enrollable_id_selections, only: [:index]

  # GET /students
  # GET /students.json
  def index
    @q = current_center.students.search params[:q]

    @students = @q.result(distinct: true)
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

  # POST /students/1/create_bill
  def create_bill
    bill = Bill.new
    bill.student_id = @student.id
    bill.center_id = current_center.id

    if bill.save
      redirect_to bill, notice: 'Bill was successfully created.'
    else
      redirect_to @student, alert: 'Bill failed to be created. Reasons: ' + bill.errors.messages[:base].join(",")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = current_center.students.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:branch_id, :group_id, :ic, :first_name, :last_name, :dob, :email, :phone_code, :phone_number, :backup_phone_code, :backup_phone_number, :school_name, :is_active)
  end

  def set_branches
    @branches = current_center.branches.by_name.to_a.collect { |b| [b.name, b.id] }
  end

  def set_groups
    @groups = current_center.groups.by_name.collect { |g| [g.name, g.id] }
  end

  def set_group_selections
    @group_selections = current_center.groups.order(:name).collect { |g| [ g.name, g.id ] }
  end

  def set_branch_selections
    @branch_selections = current_center.branches.order(:name).collect { |b| [ b.name, b.id ] }
  end

  def set_enrollable_type_selections
    @enrollable_type_selections = [["Quantity Fee", "QuantityFee"], ["Combination Fee", "CombinationFee"]]
  end

  def set_enrollable_id_selections
    @enrollable_id_selections = Hash.new
    @enrollable_id_selections["Combination Fee"] = current_center.combination_fees.order(:name).collect { |q| [q.name, q.id] }
    @enrollable_id_selections["Quantity Fee"] = current_center.quantity_fees.order(:name).collect { |q| [q.name, q.id] }
  end
end

