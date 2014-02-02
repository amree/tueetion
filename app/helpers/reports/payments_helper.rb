module Reports::PaymentsHelper
  def yearly_payments_chart_data
    (0..11).map do |offset|
      start_datetime = Time.zone.now.at_beginning_of_year + offset.month
      end_datetime = start_datetime.at_end_of_month

      amount = Bill.joins(:payments)
                .where(
                  bills: { center_id: 1 },
                  payments: { paid_at: start_datetime..end_datetime }
                ).sum('payments.amount')

      number_with_precision(amount, precision: 2).to_f
    end
  end
end
