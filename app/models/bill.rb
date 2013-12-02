class Bill < ActiveRecord::Base
  belongs_to :center
  belongs_to :student
  has_many :bill_items
  has_many :payments

  scope :active, -> { where(is_active: true) }

  before_validation :set_default_values, if: "self.new_record?"
  validate :check_current_month_bill, if: "self.new_record?"

  def real_number
    "#{year}#{month}#{number.to_s.rjust(5, '0')}"
  end

  def count_total_amount
    total_amount = 0

    self.bill_items.each do |bill_item|
      total_amount = total_amount + bill_item.amount
    end

    self.total_amount = total_amount
  end

  def total_amount_paid
    self.payments.sum(:amount)
  end

  def self.generate(student)
    bill = Bill.new
    bill.student_id = student.id
    bill.center_id  = student.center_id

    bill
  end

  protected

  def set_default_values
    self.month = Date.today.strftime("%m")
    self.year = Date.today.strftime("%Y")

    generate_latest_number
    generate_bill_items
  end

  def check_current_month_bill
    if Center.find(self.center_id).bills.where("created_at between ? and ?", Date.today.at_beginning_of_month, Date.today.end_of_month + 1).active.count >= 1
      errors.add(:base, "Bill for #{I18n.t("date.month_names")[self.month]} #{self.year} already exits.")
    end
  end

  private

  def generate_latest_number
    self.number = (Center.find(self.center_id).bills.where("created_at between ? and ?", Date.today.at_beginning_of_year, Date.today.end_of_year + 1).maximum(:number) || 0) + 1
  end

  def generate_bill_items
    self.student.enrolls.each do |enroll|
      price = enroll.enrollable.price

      self.bill_items.new(name: "Payment for " + enroll.name, amount: price)
    end
  end
end
