require 'test_helper'

class CombinationItemFeeTest < ActiveSupport::TestCase
  setup do
    @combo_item = combination_item_fees(:combo1_bm)
  end

  test "subject selection should be unique for each combo" do
    dup = @combo_item.dup
    dup.invalid?

    assert dup.errors[:subject_id].present?
  end

  test "subject should be valid" do
    dup = @combo_item.dup
    dup.subject_id = nil
    dup.invalid?

    assert dup.errors[:subject].present?
  end

  test "combo fee should be valid" do
    dup = @combo_item.dup
    dup.combination_fee_id = nil
    dup.invalid?

    assert dup.errors[:combination_fee].present?
  end
end
