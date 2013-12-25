require 'test_helper'

class EnrollTest < ActiveSupport::TestCase
  setup do
    @ali = students(:ali)

    @quantity_fee_enroll = enrolls(:ali_quantity_fee)
    @combination_fee_enroll = enrolls(:ali_combination_fee)

    @bm_quantity_fee = quantity_fees(:bm_quantity_fee)
  end

  test "should generate the correct name" do
    assert @quantity_fee_enroll.name, "Bahasa Melayu"
  end

  test "subject should be unique by student for QuantityFee" do
    enroll = QuantityFeeEnroll.new
    enroll.student_id = @ali.id
    enroll.enrollable = @bm_quantity_fee
    enroll.valid?

    assert enroll.errors[:enrollable_id].present?
  end

  test "destroying enroll should destroy associated enroll subjects (quantity)" do
    @quantity_fee_enroll.destroy

    assert EnrollSubject.where(enroll_id: @quantity_fee_enroll.id).blank?
  end

  test "destroying enroll should destroy associated enroll subjects (combination)" do
    @combination_fee_enroll.destroy

    assert EnrollSubject.where(enroll_id: @combination_fee_enroll.id).blank?
  end
end

