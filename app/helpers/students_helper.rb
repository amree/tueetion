module StudentsHelper
  def full_phone_number(student)
    "(#{student.phone_code}) #{student.phone_number}"
  end
end
