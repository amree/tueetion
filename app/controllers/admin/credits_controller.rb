class Admin::CreditsController < ApplicationController
  before_action :require_admin
  before_action :set_credit, only: [:edit, :update, :destroy, :show]
  before_action :set_centers, only: [:new, :create, :edit, :update]

  def index
    @credits = Credit.joins(:center).by_latest
  end

  def show
  end

  def new
    @credit = Credit.new
    @credit.transactions.build
  end

  def edit
  end

  def create
    @credit = Credit.new(credit_params)

    if @credit.save
      redirect_to [:admin, @credit], notice: 'Credit was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @credit.update_attributes(credit_params)
      redirect_to [:admin, @credit], notice: 'Credit was successfully updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @credit.destroy

    redirect_to admin_credits_path, notice: 'Credit deleted.'
  end

  private

  def set_credit
    @credit = Credit.find(params[:id])
  end

  def set_centers
    @centers = Center.order(:name).collect { |c| [ c.name, c.id ] }
  end

  def credit_params
    params.require(:credit).permit(:center_id, :amount, transactions_attributes: [:id, :reference_number, :merchant, :value, :paid_at])
  end
end
