json.array!(@settings_credits) do |settings_credit|
  json.extract! settings_credit, :center_id, :count, :amount, :transaction_number, :payment_method, :paid_at
  json.url settings_credit_url(settings_credit, format: :json)
end
