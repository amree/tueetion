class Bill < ActiveRecord::Base
  belongs_to :center
  belongs_to :student
  has_many :bill_items, dependent: :destroy
  has_many :payments, dependent: :destroy

  scope :active,    -> { where(is_active: true) }
  scope :unpaid,    -> { where(is_paid: false) }
  scope :overdue,   -> { where(is_overdue: true) }
  scope :by_latest, -> { order("created_at desc") }
  scope :by_month,  ->(time) { where(created_at: time..time.end_of_month,
                                     is_active: true) }

  before_validation :set_default_values, if: "self.new_record?"
  validate :check_current_month_bill, if: "self.new_record?"

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

  protected

  def set_default_values
    self.month = Date.today.strftime("%m")
    self.year = Date.today.strftime("%Y")

    generate_latest_number
    generate_full_number
    generate_bill_items
  end

  def check_current_month_bill
    if Center.find(self.center_id)
             .bills
             .where("created_at between ? and ?",
                    Date.today.at_beginning_of_month,
                    Date.today.end_of_month + 1)
             .where("student_id = ?",
                    self.student_id)
             .active
             .count >= 1

      errors.add(:base, "Bill for #{I18n.t("date.month_names")[self.month]} #{self.year} already exits.")
    end
  end

  private

  def generate_latest_number
    self.number = (Center.find(self.center_id).bills.where("created_at between ? and ?", Date.today.at_beginning_of_year, Date.today.end_of_year + 1).maximum(:number) || 0) + 1
  end

  def generate_full_number
    self.full_number = "#{self.year}#{self.month.to_s.rjust(2, '0')}#{self.number.to_s.rjust(5, '0')}"
  end

  def generate_bill_items
    self.student.enrolls.each do |enroll|
      price = enroll.enrollable.price

      self.bill_items.new(name: "Payment for " + enroll.name, amount: price)
    end
  end
end
