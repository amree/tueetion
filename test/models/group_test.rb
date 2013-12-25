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

  test "removing group should nullify it in Student" do
    student = students(:ali)
    @group.destroy
    student.reload

    assert student.group_id.nil?
  end
end
