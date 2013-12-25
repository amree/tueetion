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

  test "phone number should exists" do
    @ali.phone_number = nil
    @ali.valid?

    assert @ali.errors[:phone_number].present?
  end

  test "phone code should exists" do
    @ali.phone_code = nil
    @ali.valid?

    assert @ali.errors[:phone_code].present?
  end

  test "branch should be valid if inserted" do
    @ali.branch_id = 1000
    @ali.valid?

    assert @ali.errors[:branch].present?
  end

  test "group should be valid if inserted" do
    @ali.group_id = 1000
    @ali.valid?

    assert @ali.errors[:group].present?
  end

  test "destroying student will also destroy his/her bills" do
    @ali.destroy

    assert Bill.where(student_id: @ali.id).blank?
  end

  test "destroying student will also destroy his/her enrolls" do
    @ali.destroy

    assert Enroll.where(student_id: @ali.id).blank?
  end

  test "destroying student will also destroy his/her messages" do
    @ali.destroy

    assert Message.where(student_id: @ali.id).blank?
  end
end
