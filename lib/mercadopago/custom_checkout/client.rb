require "mercadopago/custom_checkout/card_tokens"
require "mercadopago/custom_checkout/customers"
require "mercadopago/custom_checkout/identification_types"
require "mercadopago/custom_checkout/payment_methods"
require "mercadopago/custom_checkout/payments"

module MercadoPago
  module CustomCheckout
    # You can create a Client object to interact with a MercadoPago
    # account through the API.
    #
    # You will need the access_token.
    #
    # Usage example:
    #
    #  client = MercadoPago::CustomCheckout::Client.new(access_token)
    #
    class Client
      attr_reader :sandbox

      # Creates an instance to make calls to the MercadoPago CustomCheckout API.
      def initialize(access_token)
        @access_token = access_token
        @sandbox = false
      end

      def valid?
        me.key?(:id)
      end

      # Enables or disables sandbox mode.
      def sandbox_mode(status = nil)
        @sandbox = status unless status.nil?
      end

      # CardTokens
      include MercadoPago::CustomCheckout::CardTokens

      # Customers
      include MercadoPago::CustomCheckout::Customers

      # Identification Types
      include MercadoPago::CustomCheckout::IdentificationTypes

      # Payment Methods
      include MercadoPago::CustomCheckout::PaymentMethods

      # Payments
      include MercadoPago::CustomCheckout::Payments

    private

      def me
        @me ||= MercadoPago::Core::Request.get_request(
          "/users/me",
          { access_token: @access_token }
        )
      end

    end

  end
end
