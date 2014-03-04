class Admin::SubscriptionsController < ApplicationController
  before_action :require_admin
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_action :set_centers, only: [:new, :create, :edit, :update]

  # GET /admin/subscriptions
  def index
    @subscriptions = Subscription.all
  end

  # GET /admin/subscriptions/1
  def show
  end

  # GET /admin/subscriptions/new
  def new
    @subscription = Subscription.new
    @subscription.transactions.build
  end

  # GET /admin/subscriptions/1/edit
  def edit
  end

  # POST /admin/subscriptions
  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      redirect_to [:admin, @subscription], notice: 'Subscription was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/subscriptions/1
  def update
    if @subscription.update(subscription_params)
      redirect_to [:admin, @subscription], notice: 'Subscription was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/subscriptions/1
  def destroy
    @subscription.destroy

    redirect_to admin_subscriptions_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:center_id, :quantity, :start_at, :end_at, transactions_attributes: [:id, :reference_number, :merchant, :value, :paid_at])
  end

  def set_centers
    @centers = Center.order(:name).collect { |c| [ c.name, c.id ] }
  end
end
