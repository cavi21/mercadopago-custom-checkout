module MercadoPago
  module CustomCheckout
    class Account
      def initialize(public_key: nil, access_token: nil)
        @client = MercadoPago::Core::Client.new(public_key, access_token)
      end

      def valid?
        me.key?(:id)
      end

      def card_issuers(payment_method_id:)
        @client.call(:card_issuers, :retrieve, { payment_method_id: payment_method_id })
      end

      def create_card_tokens(payload = {})
        @client.call(:card_tokens, :create, payload)
      end

      def add_card_to_customer(customer_id:, **payload)
        @client.call(:cards, :create, payload.merge(customer_id: customer_id))
      end

      def customers(payload = {})
        if response = @client.call(:customers, :search, payload)
          binding.pry
        else
          []
        end
      end

      def payment_methods
        @client.call(:payment_methods, :retrieve)
      end

      # # Card Tokens
      # include MercadoPago::CustomCheckout::CardTokens

      # # Customers
      # include MercadoPago::CustomCheckout::Customers

      # # Identification Types
      # include MercadoPago::CustomCheckout::IdentificationTypes

      # # Payment Methods
      # include MercadoPago::CustomCheckout::PaymentMethods

      # # Payments
      # include MercadoPago::CustomCheckout::Payments

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
