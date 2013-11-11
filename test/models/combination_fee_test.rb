require 'test_helper'

class CombinationFeeTest < ActiveSupport::TestCase
  setup do
    @combo = combination_fees(:combo1)
  end

  test "center should not be blank" do
    @combo.center_id = nil
    @combo.valid?

    assert @combo.errors[:center_id].present?
  end

  test "center should exists" do
    @combo.center_id = 999
    @combo.valid?

    assert @combo.errors[:center].present?
  end

  test "name should not be blank" do
    @combo.name = nil
    @combo.valid?

    assert @combo.errors[:name].present?
  end

  test "name should be unique by center" do
    dup = @combo.dup
    dup.valid?

    assert dup.errors[:name].present?
  end

  test "price should not blank" do
    @combo.price = nil
    @combo.valid?

    assert @combo.errors[:price].present?
  end

  test "price should not be negative" do
    @combo.price = -1
    @combo.valid?

    assert @combo.errors[:price].present?
  end

  test "price should be able to accept precision number" do
    @combo.price = 10.10
    @combo.valid?

    assert @combo.errors[:price].blank?
  end
end
