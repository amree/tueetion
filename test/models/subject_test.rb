require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  setup do
    @bm = subjects(:bm)
  end

  test "name should be unique" do
    dup = @bm.dup

    assert dup.invalid?
    assert dup.errors[:name].present?
  end

  test "name should not be blank" do
    dup = @bm.dup
    dup.name = nil

    dup.invalid?

    assert dup.errors[:name].present?
  end

  test "destroying subject will also destroy associated quantity fees" do
    @bm.destroy

    assert QuantityFee.where(subject_id: @bm.id).blank?
  end

  test "destroying subject will also destroy associated combination item fees" do
    @bm.destroy

    assert CombinationItemFee.where(subject_id: @bm.id).blank?
  end

  test "destroying subject will also destroy associated enroll subjects" do
    @bm.destroy

    assert EnrollSubject.where(subject_id: @bm.id).blank?
  end
end
