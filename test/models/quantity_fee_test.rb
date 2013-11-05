require 'test_helper'

class QuantityFeeTest < ActiveSupport::TestCase
  setup do
    @bm = quantity_fees(:bm_pakar)
  end

  test "name should not be blank" do
    dup = @bm.dup
    dup.name = nil

    dup.valid?

    assert dup.errors[:name].present?
  end

  test "name should be unique" do
    dup = @bm.dup

    dup.valid?

    assert dup.errors[:name].present?
  end

  test "subject should not be blank" do
    @bm.subject_id = nil
    @bm.valid?

    assert @bm.errors[:subject_id].present?
  end

  test "subject should be valid for current center" do
    @bm.subject_id = 999
    @bm.valid?

    assert @bm.errors[:subject].present?
  end

  test "price should not be blank" do
    @bm.price = nil
    @bm.valid?

    assert @bm.errors[:price].present?
  end

  test "price should not be negative" do
    @bm.price = -1
    @bm.valid?

    assert @bm.errors[:price].present?
  end

  test "price should be able to accept precision number" do
    @bm.price = 10.10
    @bm.valid?

    assert @bm.errors[:price].blank?
  end
end
