module MercadoPago
  module CustomCheckout
    class Account
      attr_reader :client

      def initialize(public_key: nil, access_token: nil)
        @client = MercadoPago::Core::Client.new(public_key, access_token)
      end

      def inspect
        "#<#{self.class.name} public_key:#{@client.public_key}>"
      end

      def valid?
        me.key?(:id)
      end

      ## ---- Informative Methods ---- ##
      # This methods allows to retrieve information only, there is no create/update
      # just informative, about :payment_methods, or :card_issuers of a PaymentMethod
      # etc.
      # All of them are accesible with the :public_key.
      def payment_methods
        return @payment_methods unless @payment_methods.nil? || @payment_methods.empty?

        response = @client.call(:payment_methods, :retrieve)
        if response.is_a?(Array)
          @payment_methods = response.map do |method|
            PaymentMethod.new(self, method)
          end
        else
          response
        end
      end

      def payment_method(bin_number)
        number = bin_number.gsub(/\s*/, '')[0,6]
        payment_methods.select do |method|
          bin = method.bin
          bin &&
          (number.match(bin[:pattern]) ? true : false) &&
          (!bin[:exclusion_pattern] || !number.match(bin[:exclusion_pattern]))
        end
      end

      def card_issuers_for(payment_method_id)
        response = @client.call(:card_issuers, :retrieve, {
          payment_method_id: payment_method_id
        })
        if response.is_a?(Array)
          response.map do |issuer|
            CardIssuer.new(issuer)
          end
        else
          response
        end
      end

      def installments_for(payment_method_id)
        @client.call(:installments, :retrieve, {
          payment_method_id: payment_method_id
        })
      end

      def identification_types
        return @identification_types unless @identification_types.nil?

        response = @client.call(:identification_types, :retrieve)
        if response.is_a?(Array)
          @identification_types = response.map do |identification|
            IdentificationType.new(identification)
          end
        else
          if response[:status] == 404
            @identification_types = []
          else
            response
          end
        end
      end
      ## ---- END - Informative Methods ---- ##


      # The payload to create the card token is:
      # {
      #   cardNumber: '',
      #   securityCode: '',
      #   cardExpirationMonth: '',
      #   cardExpirationYear: '',
      #   cardholderName: '',
      #   paymentMethodId: '',
      #   docType: '', # Except for México
      #   docNumber: '' # Except for México
      # }
      def create_card_token(**payload)
        response = @client.call(:card_tokens, :create, payload)
        if response.key?(:error)
          response
        else
          CardToken.new(@client, response)
        end
      end

      def create_payment(**payload)
        @client.call(:payments, :create, payload)
      end

      def create_customer(**payload)
        @client.call(:customers, :create, payload)
      end

      def add_card_to_customer(customer_id:, **payload)
        @client.call(:cards, :create, payload.merge(customer_id: customer_id))
      end

      def customer(customer_id)
        @client.call(:customers, :retrieve, { id: customer_id })
      end

      def customers(**payload)
        if response = @client.call(:customers, :search, payload)
          response[:results]
        else
          []
        end
      end

      # # Card Tokens
      # include MercadoPago::CustomCheckout::CardTokens

      # # Customers
      # include MercadoPago::CustomCheckout::Customers

      # # Identification Types
      # include MercadoPago::CustomCheckout::IdentificationTypes

      # # Payment Methods
      # include MercadoPago::CustomCheckout::PaymentMethods

      # # Payments
      # include MercadoPago::CustomCheckout::Payments

      private

      def me
        @me ||= @client.call(:users, :me)
      end
    end
  end
end
