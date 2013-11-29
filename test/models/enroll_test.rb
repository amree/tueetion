require 'test_helper'

class EnrollTest < ActiveSupport::TestCase
  setup do
    @ali = students(:ali)
    @quantity_fee_enroll = enrolls(:ali_quantity_fee)
    @bm_quantity_fee = quantity_fees(:bm_quantity_fee)

    @combo2 = combination_fees(:combo2)
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
end

