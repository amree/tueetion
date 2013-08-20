require 'test_helper'

class CenterTest < ActiveSupport::TestCase
  setup do
    @kota_bharu = centers(:kota_bharu)
  end

  test "name should not be nil" do
    @dup = @kota_bharu.dup

    @dup.name = nil

    assert @dup.invalid?, "Name should not be nil"
  end
end
