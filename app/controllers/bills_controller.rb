class BillsController < ApplicationController
  before_action :set_bill, except: [:index]
  before_action :set_student, except: [:index]

  # GET /bills
  # GET /bills.json
  def index
    @q = current_center.bills.by_latest.search params[:q]

    @bills = @q.result
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: params[:id],
               orientation: 'Landscape',
               page_size: 'A5'
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url }
      format.json { head :no_content }
    end
  end

  # PATCH /bills/1/activate
  def activate
    @bill.is_active = true

    if @bill.save
      redirect_to @bill, notice: "Bill was successfully activated."
    else
      redirect_to @bill, notice: "Bill was unsuccessfully activated. Reasons: " + @bill.errors[:base].join(",")
    end
  end

  # PATCH /bills/1/deactivate
  def deactivate
    @bill.is_active = false

    if @bill.save
      redirect_to @bill, notice: "Bill was successfully deactivated."
    else
      redirect_to @bill, notice: "Bill was unsuccessfully deactivated. Reasons: " + @bill.errors[:base].join(",")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bill
    @bill = current_center.bills.find(params[:id])
  end

  def set_student
    @student = current_center.students.find(@bill.student_id)
  end
end
