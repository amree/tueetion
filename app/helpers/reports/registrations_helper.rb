module Reports::RegistrationsHelper
  def registrations_chart_data
    (0..11).map do |offset|
      start_datetime = Time.zone.now.at_beginning_of_year + offset.month
      end_datetime = start_datetime.at_end_of_month

      Student.where(
        center_id: current_user.center_id,
        created_at: start_datetime..end_datetime).count
    end
  end
end
