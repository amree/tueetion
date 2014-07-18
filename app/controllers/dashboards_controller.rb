class DashboardsController < ApplicationController
  before_filter :check_center

  def index
    if current_user.is_admin?
      redirect_to admin_centers_path
    else
      @payments = Payment.joins(:bill).where(bills: { center_id: current_center.id }).order("created_at desc").limit(10)

      @overdue_bills = current_center.bills.active.overdue.order("created_at desc").limit(10)

      subscription_usage = SubscriptionUsage.new(current_center)
      @subscription_used = subscription_usage.current
      @subscription_total = subscription_usage.max

      @credit_balance = current_center.credit_balance

      @unpaid_bill_counts = current_center.bills.active.unpaid.count

      @overdue_bill_counts = current_center.bills.active.overdue.count

      @current_month = Time.zone.now.strftime '%B'
    end
  end
end
