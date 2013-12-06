class DashboardsController < ApplicationController
  before_filter :check_center

  def index
    @payments = Payment.joins(:bill).where(bills: { center_id: current_center.id }).order("created_at desc").limit(10)

    @overdue_bills = current_center.bills.overdue.order("created_at desc").limit(10)
  end
end
