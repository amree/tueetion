json.array!(@bills) do |bill|
  json.extract! bill, :center_id, :student_id, :number, :total_amount, :is_overdue, :is_paid, :overdue_at
  json.url bill_url(bill, format: :json)
end
