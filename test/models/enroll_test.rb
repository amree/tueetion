require 'test_helper'

class EnrollTest < ActiveSupport::TestCase
  setup do
    @quantity_fee = enrolls(:ali_quantity_fee)
    @bi = quantity_fees(:bi_quantity_fee)
  end

  test "should generate the correct name" do
    assert @quantity_fee.name, "Bahasa Melayu"
  end

  test "should create the correct enroll subjects" do
    dup = @quantity_fee.dup
    dup.enrollable = @bi

    assert dup.save
    assert EnrollSubject.find_by_enroll_id(dup.id).present?
    assert_equal dup.enrollable.subject_id,
                 EnrollSubject.find_by_enroll_id(dup.id).subject_id
  end
end

