json.array!(@combination_fees) do |combination_fee|
  json.extract! combination_fee, :center_id, :name, :min_subjects, :max_subjects, :price, :is_active
  json.url combination_fee_url(combination_fee, format: :json)
end
