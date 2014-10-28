class BillOverduerWorker
  @queue = :bill

  def self.perform(id)
    bill = Bill.find(id)

    if bill.present?
      bill.overdue_at = Time.zone.now
      bill.is_overdue = true
      bill.save
    end
  end
end
