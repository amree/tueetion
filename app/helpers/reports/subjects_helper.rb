module Reports::SubjectsHelper
  def subject_enrollment_chart_data
    Subject.order(:name).map do |subject|
      [subject.name, EnrollSubject.where(subject_id: subject.id).count]
    end
  end
end
