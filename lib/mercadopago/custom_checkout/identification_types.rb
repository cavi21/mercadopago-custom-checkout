module MercadoPago
  module CustomCheckout
    module IdentificationTypes
      # Retrieves the available identification types.
      #
      def identification_types
        response = retrieve_identification_types
        if response[:error].nil?
          response.map do |data|
            MercadoPago::V1::Entities::IdentificationType.new(data)
          end
        else
          response
        end
      end

    private

      def retrieve_identification_types
        MercadoPago::Core::Request.get_request(
          "/v1/identification_types",
          { access_token: @access_token }
        )
      end
    end
  end
end
