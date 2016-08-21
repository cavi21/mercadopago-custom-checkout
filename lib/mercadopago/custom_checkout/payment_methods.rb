module MercadoPago
  module CustomCheckout
    module PaymentMethods
      # Retrieves the available payment methods.
      def retrieve_payment_methods
        MercadoPago::Core::Request.get_request(
          "/v1/payment_methods",
          { access_token: @access_token }
        )
      end

      # Retrieves information about the installments options for a payment method.
      #
      # The payment_method_id or bin are required
      # payload = {
      #   payment_method_id=:id | bin=:bin
      # }
      def retrieve_installments(payload = {})
        payload = payload.merge(access_token: @access_token)

        MercadoPago::Core::Request.get_request(
          "/v1/payment_methods/installments",
          payload
        )
      end

      # Retrieves information about the payment methods issuers.
      #
      # The payment_method_id is required
      # payload = {
      #   payment_method_id=:id
      # }
      def retrieve_card_issuers(payload = {})
        payload = payload.merge(access_token: @access_token)

        MercadoPago::Core::Request.get_request(
          "/v1/payment_methods/card_issuers",
          payload
        )
      end
    end
  end
end
