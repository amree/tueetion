module DashboardsHelper
  def payments_chart_data
    (Time.zone.now.to_date.at_beginning_of_month..Time.zone.now.to_date).map do |date|
      Payment
        .joins(:bill)
        .where(
          payments: { paid_at: date..(date + 1) },
          bills: { center_id: current_user.center_id } ).sum("payments.amount").to_f
    end
  end
end
