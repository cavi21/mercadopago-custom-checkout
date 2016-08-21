require 'test_helper'

class MercadoPago::CustomCheckoutTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MercadoPago::CustomCheckout::VERSION
  end
end
