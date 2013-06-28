json.array!(@centers) do |center|
  json.extract! center, :name
  json.url center_url(center, format: :json)
end
