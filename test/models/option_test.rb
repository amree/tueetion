require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  setup do
    @option = options(:pakar)
  end

  test "should be a valid time zone" do
    @option.time_zone = "Kota Bharu"

    assert @option.invalid?
    assert @option.errors[:time_zone].present?
  end
end
