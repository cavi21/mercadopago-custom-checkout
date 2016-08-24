module MercadoPago
  module CustomCheckout
    class Customer

      def self.search(payload = {})
        payload = payload.merge(access_token: @access_token)

        MercadoPago::Core::Request.get_request(
          "/v1/customers/search",
          payload
        )
      end

      # Create a customer.
      #
      # - payload: Contains the data required to create the customer.
      def create_customer(payload = {})
        payload = MultiJson.dump(payload)

        MercadoPago::Core::Request.post_request(
          "/v1/customers?access_token=#{@access_token}",
          payload
        )
      end

      # Retrieve a customer.
      #
      # - customer_id: The ID of the customer to be retrieved.
      def retrieve_customer(customer_id)
        MercadoPago::Core::Request.get_request(
          "/v1/customers/#{customer_id}",
          { access_token: @access_token }
        )
      end

      # Update a customer.
      #
      # - customer_id: The ID of the customer to be updated.
      # - payload: Contains the data required to update the customer.
      def update_customer(customer_id, payload = {})
        payload = MultiJson.dump(payload)

        MercadoPago::Core::Request.put_request(
          "/v1/customers/#{customer_id}?access_token=#{@access_token}",
          payload
        )
      end

      # Delete a customer.
      #
      # - customer_id: The ID of the customer to be deleted.
      def delete_customer(customer_id)
        MercadoPago::Core::Request.delete_request(
          "/v1/customers/#{customer_id}",
          { access_token: @access_token }
        )
      end

      ###### CARDS ######

      # Retrieves all customer cards.
      #
      # - customer_id: The ID of the customer to retrieve the cards.
      def retrieve_customer_cards(customer_id)
        MercadoPago::Core::Request.get_request(
          "/v1/customers/#{customer_id}/cards",
          { access_token: @access_token }
        )
      end

      # Create a customer card.
      #
      # - customer_id: The ID of the customer to retrieve the cards.
      def create_customer_card(customer_id, payload = {})
        payload = MultiJson.dump(payload)

        MercadoPago::Core::Request.post_request(
          "/v1/customers/#{customer_id}/cards?access_token=#{@access_token}",
          payload
        )
      end
    end
  end
end
