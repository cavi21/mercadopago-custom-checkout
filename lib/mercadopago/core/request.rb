require 'faraday'
require 'multi_json'

module MercadoPago
  module Core
    # This maybe could be refactor to use the same Request module as the
    # gem 'mercadopago' from Ombulabs (https://github.com/ombulabs/mercadopago)
    # that it's in MercadoPago::Request instead of MercadoPago::Core::Request
    module Request
      extend self

      class Error < StandardError; end

      MIME_JSON = 'application/json'.freeze
      MERCADOPAGO_RUBY_SDK_VERSION = '0.3.4'.freeze

      # This URL is the base for all API calls.
      #
      MERCADOPAGO_URL = 'https://api.mercadopago.com'.freeze

      # Makes a POST request to the MercadoPago API.
      #
      # - path: the path of the API to be called.
      # - payload: the data to be trasmitted to the API.
      # - headers: the headers to be transmitted over the HTTP request.
      #
      def post_request(path, payload, headers = {})
        raise Error('No data given') if payload.nil? || payload.empty?

        make_request(:post, path, payload, headers)
      end

      # Makes a GET request to the MercadoPago API.
      #
      # - path: the path of the API to be called, including any query string parameters.
      # - headers: the headers to be transmitted over the HTTP request.
      #
      def get_request(path, payload = {}, headers = {})
        unless payload.empty?
          params = payload.map do |key, value|
            "#{key}=#{value}"
          end.join('&')
          path = "#{path}?#{params}" unless params.empty?
        end

        make_request(:get, path, nil, headers)
      end

      # Makes a PUT request to the MercadoPago API.
      #
      # - path: the path of the API to be called, including any query string parameters.
      # - headers: the headers to be transmitted over the HTTP request.
      #
      def put_request(path, payload, headers = {})
        raise Error('No data given') if payload.nil? || payload.empty?

        make_request(:put, path, payload, headers)
      end

    private

      def default_headers
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
      # - payload: the data to be trasmitted to the API.
      # - headers: the headers to be transmitted over the HTTP request.
      #
      def make_request(type, path, payload = nil, headers = {})
        headers = default_headers.merge(headers)
        ssl_option = { verify: true }
        connection = Faraday.new(MERCADOPAGO_URL, ssl: ssl_option)

        response = connection.send(type) do |req|
          req.url path
          req.headers = headers
          req.body = payload
        end

        MultiJson.load(response.body, symbolize_keys: true)
      rescue Exception => e
        if e.respond_to?(:response)
          MultiJson.load(e.response, symbolize_keys: true)
        else
          raise e
        end
      end

    end
  end
end
