class BillDeactivatorWorker
  @queue = :bill

  def self.perform(id)
    bill = Bill.active.find(id)

    if bill.present?
      bill.is_active = false
      bill.save
    end
  end
end
