class DashboardsController < ApplicationController
  before_filter :check_center

  def index
    @payments = Payment.joins(:bill).where(bills: { center_id: current_center.id }).order("created_at desc").limit(10)

    @overdue_bills = current_center.bills.active.overdue.order("created_at desc").limit(10)

    @student_used_counts = current_center.students.count
    @student_credit_counts = current_center.students.count

    # Get available SMS
    @sms_used_counts = 0
    @sms_credit_counts = 0

    current_center.credits.available.each do |credit|
      @sms_credit_counts += credit.amount
      @sms_used_counts += credit.used
    end

    @unpaid_bill_counts = current_center.bills.active.unpaid.count

    @overdue_bill_counts = current_center.bills.active.overdue.count

    @current_month = Time.zone.now.strftime '%B'
  end
end
