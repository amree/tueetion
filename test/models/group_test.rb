require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup do
    @group = groups(:menengah)
  end

  test "name should be unique by center" do
    dup = @group.dup
    dup.invalid?

    assert dup.errors[:name].present?, "Name should be unique"
  end

  test "name should not be blank" do
    dup = @group.dup
    dup.name = nil
    dup.valid?

    assert dup.errors["name"].present?
  end
end
