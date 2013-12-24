json.array!(@students) do |student|
  json.extract! student, :id, :ic, :first_name, :last_name, :dob, :email, :phone_number, :school_name
  json.url student_url(student, format: :json)
end
