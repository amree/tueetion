require 'test_helper'

class CombinationFeeEnrollTest < ActiveSupport::TestCase
  setup do
    @ali = students(:ali)
    @ali_combination_fee = enrolls(:ali_combination_fee)
    @combination_fee = combination_fees(:combo1)
    @bi = quantity_fees(:bi_quantity_fee)
  end

  test "should be invalid without enrollable" do
    enroll = CombinationFeeEnroll.new
    enroll.student_id = @ali.id

    assert enroll.invalid?
  end

  test "should be invalid with invalid enrollable" do
    enroll = CombinationFeeEnroll.new
    enroll.student_id = @ali.id
    enroll.enrollable_id   = 100
    enroll.enrollable_type = 'CombinationFee'

    assert enroll.invalid?
  end

  test "should be invalid with other center's combination fee" do
    combination_fee = combination_fees(:combo_kami)

    enroll = CombinationFeeEnroll.new
    enroll.student_id = @ali.id
    enroll.enrollable_id = combination_fee.id
    enroll.enrollable_type = 'CombinationFee'

    assert enroll.invalid?
  end

  test "should be able to create enroll of combination fee" do
    dup = @ali_combination_fee.dup
    dup.enrollable_id = @bi.id

    assert dup.save
  end

  test "should create the correct enroll subjects" do
    subject_count = @combination_fee.subjects.count

    dup = @ali_combination_fee.dup
    dup.save

    assert subject_count, dup.subjects.count
  end
end
