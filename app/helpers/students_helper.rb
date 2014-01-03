module StudentsHelper
  def full_phone_number(code, number)
    if code.present? && number.present?
      "(#{code}) #{number}"
    else
      "-"
    end
  end
end
