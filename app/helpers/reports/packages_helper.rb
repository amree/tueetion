module Reports::PackagesHelper
  def package_enrollment_chart_data
    ids = current_user.center.combination_fees.joins(:enrolls).map(&:id)

    Enroll.where(enrollable_type: 'CombinationFee', enrollable_id: ids).group(:enrollable_id).count.map do |enroll|
      [CombinationFee.find(enroll[0]).name, enroll[1]]
    end
  end
end
