require 'test_helper'

class EnrollSubjectTest < ActiveSupport::TestCase
  setup do
    @quantity_fee = enroll_subjects(:ali_quantity_fee_subject)
    @combination_fee1 = enroll_subjects(:ali_combination_fee_subject_bm)
    @combination_fee2 = enroll_subjects(:ali_combination_fee_subject_bi)
  end

  test "should destroy enroll (for QuantityFee)" do
    @quantity_fee.destroy

    assert Enroll.where(id: @quantity_fee.enroll_id).blank?
  end

  test "should destroy enroll (for CombinationFee)" do
    @combination_fee1.destroy
    @combination_fee2.destroy

    assert Enroll.where(id: @combination_fee2.enroll_id).blank?
  end
end
