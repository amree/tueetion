require 'test_helper'

class CombinationFeeEnrollTest < ActiveSupport::TestCase
  setup do
    @ali_combination_fee = enrolls(:ali_combination_fee)
    @combination_fee = combination_fees(:combo1)
  end

  test "should be able to create enroll of combination fee" do
    dup = @ali_combination_fee.dup

    assert dup.save
  end

  test "should create the correct enroll subjects" do
    subject_count = @combination_fee.subjects.count

    dup = @ali_combination_fee.dup
    dup.save

    assert subject_count, dup.subjects.count
  end
end
