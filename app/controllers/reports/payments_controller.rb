class Reports::PaymentsController < ApplicationController
  before_filter :require_owner

  def index
    @current_year = Time.zone.now.strftime '%Y'
    @payments = Payment.includes(:bill).includes(:user).where(bills: { center_id: current_center.id }).order("payments.created_at DESC")
  end
end
