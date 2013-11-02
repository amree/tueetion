require 'test_helper'

class BranchTest < ActiveSupport::TestCase
  setup do
    @branch = branches(:kb)
  end

  test "name should be unique by center" do
    branch = @branch.dup
    branch.valid?

    assert branch.errors[:name].present?
  end
end
