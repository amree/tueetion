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

  test "name should not be unique" do
    @dup = @pakar.dup

    assert @dup.save, "Name should not be unique"
  end
end
