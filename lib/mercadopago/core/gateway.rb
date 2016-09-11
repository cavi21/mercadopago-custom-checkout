module MercadoPago
  module Core
    module Gateway
      extend self

      MIME_JSON = 'application/json'.freeze
      MERCADOPAGO_RUBY_SDK_VERSION = '0.3.4'.freeze
      MERCADOPAGO_API_URL = 'https://api.mercadopago.com'.freeze

      class Error < StandardError; end

    private

      def post(path, payload)
        raise Error.new('No data given') if payload.nil? || payload.empty?

        make_request(:post, path, payload)
      end

      def get(path, payload)
        make_request(:get, path, payload)
      end

      def put(path, payload)
        raise Error.new('No data given') if payload.nil? || payload.empty?

        make_request(:put, path, payload)
      end

      def delete(path, payload)
        make_request(:delete, path)
      end

      def headers
        {
          'User-Agent' => "MercadoPago Ruby SDK v#{MERCADOPAGO_RUBY_SDK_VERSION}",
          content_type: MIME_JSON,
          accept: MIME_JSON
        }
      end

      # Makes a HTTP request to the MercadoPago API.
      #
      # - type: the HTTP request type (:get, :post, :put, :delete).
      # - path: the path of the API to be called.
      # - json: the data to be trasmitted to the API.
      def make_request(method, path, payload = {})
        unless payload.empty?
          payload = MultiJson.dump(payload) unless method == :get
        end

        response = connection(method).send(method) do |call|
          call.url path
          call.headers = headers
          unless payload.empty?
            if method == :get
              call.params = call.params.merge(payload)
            else
              call.body = payload
            end
          end
        end

        MultiJson.load(response.body, symbolize_keys: true)
      rescue Exception => e
        if e.respond_to?(:response)
          MultiJson.load(e.response, symbolize_keys: true)
        else
          raise e
        end
      end

      def connection(method)
        Faraday.new(MERCADOPAGO_API_URL, ssl: { verify: true }) do |faraday|
          faraday.request(:url_encoded) if method == :get
          faraday.adapter(Faraday.default_adapter)
        end
      end
    end
  end
end
