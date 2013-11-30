class BillsController < ApplicationController
  before_action :set_bill, only: [:index, :show, :destroy]
  before_action :set_student, only: [:index, :show, :destroy]

  # GET /bills
  # GET /bills.json
  def index
    @bills = current_center.bills.to_a
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bill
    @bill = current_center.bills.find(params[:id])
  end

  def set_student
    @student = current_center.students.find(@bill.student_id)
  end
end
