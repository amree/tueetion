require 'test_helper'

# TODO: More test on uniqueness
class EnrollTest < ActiveSupport::TestCase
  setup do
    @quantity_fee = enrolls(:ali_quantity_fee)
    @bi = quantity_fees(:bi_quantity_fee)
  end

  test "should generate the correct name" do
    assert @quantity_fee.name, "Bahasa Melayu"
  end

  test "subject should be unique by student for QuantityFee" do
    enroll = @quantity_fee.dup
    enroll.valid?

    assert enroll.errors[:enrollable_id].present?
  end
end

