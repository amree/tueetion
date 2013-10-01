require 'test_helper'

class EnrollTest < ActiveSupport::TestCase
  setup do
    @adam = students(:adam)

    @ali_enroll = enrolls(:ali_quantity_fee)
    @kami_quantity_fee = quantity_fees(:bm_kami_quantity_fee)
  end

  test "should fail when student's center is not the same as quantity fee center" do
    # Assume it should've been 'pakar' as the center
    @ali_enroll.student_id = @adam.id

    assert @ali_enroll.invalid?
  end

  test "should create add a record in StudentSubject when saved (for QuantityFee)" do
    enroll = Enroll.create(student_id: @adam.id, enrollable: @kami_quantity_fee)

    assert_equal StudentSubject.last.enroll_id, enroll.id
  end
end
