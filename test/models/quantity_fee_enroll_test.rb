require 'test_helper'

class QuantityFeeEnrollTest < ActiveSupport::TestCase
  setup do
    @center = centers(:pakar)
  end

  test "should be invalid with no enrollable" do
    enroll = QuantityFeeEnroll.new
    enroll.student = @center.students.first

    assert enroll.invalid?
  end

  test "should be invalid with invalid enrollable" do
    enroll = QuantityFeeEnroll.new
    enroll.student = @center.students.first
    enroll.enrollable_id   = 100
    enroll.enrollable_type = 'QuantityFee'

    assert enroll.invalid?
  end

  test "should be invalid with other's quantity fee" do
    quantity_fee = quantity_fees(:sejarah_quantity_fee)

    enroll = QuantityFeeEnroll.new
    enroll.student = @center.students.first
    enroll.enrollable_id = quantity_fee.id
    enroll.enrollable_type = 'QuantityFee'

    assert enroll.invalid?
  end
end
