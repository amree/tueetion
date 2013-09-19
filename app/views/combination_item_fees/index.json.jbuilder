json.array!(@combination_item_fees) do |combination_item_fee|
  json.extract! combination_item_fee, :combination_item_fee_id, :subject_id
  json.url combination_item_fee_url(combination_item_fee, format: :json)
end
