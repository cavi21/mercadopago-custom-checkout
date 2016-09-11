require 'faraday'
require 'multi_json'

# Core
require "mercadopago/core/endpoints"
require "mercadopago/core/errors"
require "mercadopago/core/client"
require "mercadopago/core/gateway"

# CustomCheckout
require "mercadopago/custom_checkout/account"
require "mercadopago/custom_checkout/errors"
require "mercadopago/custom_checkout/resource"
require "mercadopago/custom_checkout/version"

# Resources
require "mercadopago/custom_checkout/card_issuer"
require "mercadopago/custom_checkout/card_token"
require "mercadopago/custom_checkout/identification_type"
require "mercadopago/custom_checkout/payment_method"

# require "mercadopago/custom_checkout/customer"
# require "mercadopago/custom_checkout/payment_methods"
# require "mercadopago/custom_checkout/payments"

module MercadoPago
  module CustomCheckout
  end
end
