require 'test_helper'

class EnrollTest < ActiveSupport::TestCase
  setup do
    @ali_qf = enrolls(:ali_quantity_fee)
  end

  test "should generate the correct name" do
    assert @ali_qf.name, "Bahasa Melayu"
  end
end
