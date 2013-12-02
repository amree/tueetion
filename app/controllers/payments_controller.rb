class PaymentsController < ApplicationController
  before_action :set_bill
  before_action :set_student
  before_action :set_payment, only: [:destroy]
  before_action :payment_params, only: [:create]

  def new
    @payment = Payment.new
  end

  def create
    payment = @bill.payments.new(payment_params)

    if payment.save
      redirect_to @bill, notice: 'Payment was successfully made.'
    else
      render action: 'new'
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to @bill, notice: 'Payment was successfully delted' }
      format.json { head :no_content }
    end
  end

  private

  def set_bill
    @bill = current_center.bills.find(params[:bill_id])
  end

  def set_student
    @student = @bill.student
  end

  def set_payment
    @payment = @bill.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :paid_at)
  end
end
