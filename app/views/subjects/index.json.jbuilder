json.array!(@subjects) do |subject|
  json.extract! subject, :center_id, :name, :is_active
  json.url subject_url(subject, format: :json)
end
