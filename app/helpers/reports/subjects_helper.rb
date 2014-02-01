module Reports::SubjectsHelper
  def subject_enrollment_chart_data
    current_user.center.subjects.order(:name).map do |subject|
      [subject.name, EnrollSubject.where(subject_id: subject.id).count]
    end
  end
end
