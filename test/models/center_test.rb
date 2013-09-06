require 'test_helper'

class CenterTest < ActiveSupport::TestCase
  setup do
    @pakar = centers(:pakar)
  end

  test "name should not be nil" do
    @dup = @pakar.dup

    @dup.name = nil

    assert @dup.invalid?, "Name should not be nil"
  end

  test "name should be unique" do
    @dup = @pakar.dup

    assert @dup.invalid?, "Name should be unique"
  end

  test "user should not be nil" do
    @dup = @pakar.dup

    @dup.name = 'Other name'
    @dup.user_id = nil

    assert @dup.invalid?, "There should be User (owner) for this center"
  end

  test "a user should have only one center" do
    @dup = @pakar.dup
    @dup.name = "Other name"

    assert @dup.invalid?, "A user can has only one center"
  end
end
