module MercadoPago
  module CustomCheckout
    module Payments

      def create_payment(payload)
        payload = MultiJson.dump(payload)

        MercadoPago::Core::Request.post_request(
          "/v1/payments?access_token=#{@access_token}",
          payload
        )
      end

      # def retrieve_payment(payment_id)
      #   MercadoPago::Core::Request.get_request("/v1/payments/#{payment_id}?access_token=#{@access_token}")
      # end

      # def update_payment(payment_id, payload)
      #   payload = MultiJson.dump(payload)
      #   MercadoPago::Core::Request.put_request("/v1/payments/#{payment_id}?access_token=#{@access_token}", payload)
      # end
    end
  end
end
