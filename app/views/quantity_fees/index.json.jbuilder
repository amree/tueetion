json.array!(@quantity_fees) do |quantity_fee|
  json.extract! quantity_fee, :subject_id, :price, :is_active
  json.url quantity_fee_url(quantity_fee, format: :json)
end
