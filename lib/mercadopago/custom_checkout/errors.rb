module MercadoPago
  module CustomCheckout
    class Error < StandardError; end
    class ClientError < Error; end
    class ArgumentError < Error; end
  end
end
