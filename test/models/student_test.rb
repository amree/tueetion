require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @ali = students(:ali)
  end

  test "center_id should exists" do
    @ali.center_id = nil
    @ali.valid?

    assert @ali.errors[:center_id].present?
  end

  test "center should be valid" do
    @ali.center_id = 999
    @ali.valid?

    assert @ali.errors[:center].present?
  end

  test "ic should exists" do
    @ali.ic = nil
    @ali.valid?

    assert @ali.errors[:ic].present?
  end

  test "first_name should exists" do
    @ali.first_name = nil
    @ali.valid?

    assert @ali.errors[:first_name].present?
  end

  test "last_name should exists" do
    @ali.last_name = nil
    @ali.valid?

    assert @ali.errors[:last_name].present?
  end

  test "phone should exists" do
    @ali.phone = nil
    @ali.valid?

    assert @ali.errors[:phone].present?
  end
end
