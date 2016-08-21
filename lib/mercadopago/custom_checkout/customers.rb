module MercadoPago
  module CustomCheckout
    module Customers
      # Looks for customers by many criterias.
      #
      # - payload: Contains the payload required to search for the customers.
      #
      def search_customers(payload = {})
        payload = payload.merge(access_token: @access_token)

        MercadoPago::Core::Request.get_request(
          "/v1/customers/search",
          payload
        )
      end

      # Creates a customer.
      #
      # - payload: Contains the data required to create the customer.
      def create_customer(payload)
        payload = MultiJson.dump(payload)

        MercadoPago::Core::Request.post_request(
          "/v1/customers?access_token=#{@access_token}",
          payload
        )
      end

      # # Retrieves a customer.
      # #
      # # - customer_id: The ID of the customer to be retrieved.
      # #
      # def get_customer(customer_id)
      #   MercadoPago::CustomCheckout::Customers.get(@access_token, customer_id)
      # end

      # # Updates a customer.
      # #
      # # - customer_id: The ID of the customer to be retrieved.
      # # - data: Contains the data required to update the customer.
      # #
      # def update_customer(customer_id, data)
      #   MercadoPago::CustomCheckout::Customers.update(@access_token, customer_id, data)
      # end
      #

      # def get(access_token, customer_id)
      #   MercadoPago::Core::Request.get_request("/v1/customers/#{customer_id}?access_token=#{access_token}")
      # end

      # def update(access_token, customer_id, payload)
      #   payload = MultiJson.dump(payload)
      #   MercadoPago::Core::Request.put_request("/v1/customers/#{customer_id}?access_token=#{access_token}", payload)
      # end
    end
  end
end
