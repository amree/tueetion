# status: new | in progress | invalid | sent | no credit
class Message < ActiveRecord::Base
  belongs_to :center
  belongs_to :student
  has_many :credit_usages

  before_validation :set_phone_number, if: "self.student.present?"
  before_validation :set_status_to_new, if: "self.new_record?"

  before_validation :validate_center
  before_validation :validate_student
  before_validation :validate_phone_number
  before_validation :validate_content

  after_create :enqueue_in_resque
  after_update :destroy_credit_usages, if: "self.status_changed? && self.status == 'failed'"

  protected

  def set_phone_number
    if self.student.phone_number.present?
      self.phone_number = self.student.phone_number
    end
  end

  def set_status_to_new
    self.status = "new"
  end

  def validate_center
    if self.center.nil?
      set_failed_messages("Center is invalid")
    end
  end

  def validate_student
    if self.student.nil?
      set_failed_messages("Student is invalid")
    end
  end

  def validate_phone_number
    if self.phone_number.nil?
      set_failed_messages("Phone number is invalid")
    end
  end

  def validate_content
    if self.content.nil?
      set_failed_messages("Content is invalid")
    end
  end

  def enqueue_in_resque
    unless self.status == "invalid"
      Resque.enqueue(SmsWorker, self.id)
    end
  end

  def destroy_credit_usages
    self.credit_usages.each do |usage|
      usage.destroy
    end
  end

  private

  def set_failed_messages(msg)
    if self.failed_messages.blank?
      self.failed_messages = msg
    else
      self.failed_messages = self.failed_messages + "," + msg
    end

    self.status = "invalid"
  end
end
