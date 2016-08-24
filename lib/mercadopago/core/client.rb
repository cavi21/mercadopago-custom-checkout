module MercadoPago
  module Core
    class Client
      attr_reader :public_key, :version

      # Creates an instance to make calls to the MercadoPago CustomCheckout API.
      def initialize(public_key = nil, access_token = nil)
        check_credentials!(public_key, access_token)

        @access_token = access_token if access_token
        @public_key = public_key if public_key
        @gateway = MercadoPago::Core::Gateway
        @version = @gateway::API_VERSION
      end

      def call(resource, action, data = {})
        return unless request = request_for(resource, action)
        endpoint_path, payload = build_endpoint_path(request, data)

        @gateway.send(request[:method], endpoint_path, payload)
      end

    private

      def check_credentials!(public_key = nil, access_token = nil)
        if (public_key.nil? || public_key.empty?) &&
           (access_token.nil? || access_token.empty?)
          raise ClientError.new('You must provide a :public_key or an :access_token')
        end
      end

      def request_for(resource, call)
        return unless resource = MercadoPago::Core::ENDPOINTS[resource.to_sym]
        resource[call.to_sym]
      end

      def build_endpoint_path(request, data)
        path = request[:endpoint] % data.merge(version: version)
        ["#{path}?#{token_to_use(request)}", purged_data_keys(request[:endpoint], data)]
      rescue KeyError
        nil
      end

      def token_to_use(request)
        token_name = request[:allowed_tokens].detect do |token|
          instance_variable_get("@#{token}")
        end
        "#{token_name}=#{instance_variable_get("@#{token_name}")}" if token_name
      end

      def purged_data_keys(raw_endpoint, data)
        keys = raw_endpoint.scan(/%{(\w*)}/).flatten.map(&:to_sym)
        data.delete_if { |k,v| keys.include?(k) }
      end
    end

  end
end
