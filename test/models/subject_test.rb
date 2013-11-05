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
end
