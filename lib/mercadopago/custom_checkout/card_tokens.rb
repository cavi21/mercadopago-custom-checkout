module MercadoPago
  module CustomCheckout
    module CardTokens

    end

    class CardToken

      # Creates a new card token.
      #
      # - card_token_id: The ID of the card token to be retrieved.
      #
      def self.create(payload)
        MercadoPago::Core::Request.call(:card_token, :create, {})
        # MercadoPago::Core::Request.post_request(
        #   "/v1/card_tokens?access_token=#{@access_token}",
        #   payload
        # )
      end

      def initialize(client)
        @client = client
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
        payload = MultiJson.dump(payload)

        MercadoPago::Core::Request.put_request(
          "/v1/card_tokens/#{card_token_id}?access_token=#{@access_token}",
          payload
        )
      end
    end
  end
end
