module MercadoPago
  module Core
    class Client
      attr_reader :public_key, :version
      API_VERSION = "v1".freeze

      # Creates an instance to make calls to the MercadoPago CustomCheckout API.
      def initialize(public_key = nil, access_token = nil)
        check_credentials!(public_key, access_token)

        @access_token = access_token if access_token
        @public_key = public_key if public_key
        @gateway = MercadoPago::Core::Gateway
        @version = API_VERSION
      end

      def call(resource, action, data = {})
        request = request_for!(resource.to_sym, action.to_sym)
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

      def request_for!(resource, action)
        unless MercadoPago::Core::ENDPOINTS.keys.include?(resource)
          error = "There is no :#{resource} resource. The available ones are: " \
                  "[:#{MercadoPago::Core::ENDPOINTS.keys.join(', :')}]"
          raise ResourceError.new(error)
        end
        resource = MercadoPago::Core::ENDPOINTS[resource]

        unless resource.keys.include?(action)
          error = "There is no action called :#{action}. The available actions are: "\
                  "[:#{resource.keys.join(', :')}]"
          raise ResourceError.new(error)
        end
        resource[action]
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
