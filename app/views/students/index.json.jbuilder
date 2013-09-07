json.array!(@students) do |student|
  json.extract! student, :ic, :first_name, :last_name, :dob, :email, :phone, :school_name
  json.url student_url(student, format: :json)
end
