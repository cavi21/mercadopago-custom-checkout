module MercadoPago
  module CustomCheckout
    module CardTokens
      # Creates a new card token.
      #
      # - card_token_id: The ID of the card token to be retrieved.
      #
      def create_credit_card_token(payload)
        MercadoPago::Core::Request.post_request(
          "/v1/card_tokens",
          payload
        )
      end

      # Retrieves the specified card token.
      #
      # - card_token_id: The ID of the card token to be retrieved.
      #
      def retrieve_credit_card_token(card_token_id)
        MercadoPago::Core::Request.get_request(
          "/v1/card_tokens/#{card_token_id}",
          { access_token: @access_token }
        )
      end

      # Updates the specified card token.
      #
      # - card_token_id: The ID of the card token to be updated.
      # - data: Contains the data to be updated on the specified card token.
      #
      def update_credit_card_token(card_token_id, payload = {})
        payload = payload.merge(access_token: @access_token)
        payload = MultiJson.dump(payload)

        MercadoPago::Core::Request.put_request(
          "/v1/card_tokens/#{card_token_id}",
          payload
        )
      end
    end
  end
end
