module MercadoPago
  module CustomCheckout
    module IdentificationTypes
      # Retrieves the available identification types.
      #
      def retrieve_identification_types
        MercadoPago::Core::Request.get_request(
          "/v1/identification_types",
          { access_token: @access_token }
        )
      end
    end
  end
end
