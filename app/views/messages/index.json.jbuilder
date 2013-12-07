json.array!(@messages) do |message|
  json.extract! message, :student_id, :phone_number, :content
  json.url message_url(message, format: :json)
end
