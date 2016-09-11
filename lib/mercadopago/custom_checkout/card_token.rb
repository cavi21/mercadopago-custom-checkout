module MercadoPago
  module CustomCheckout
    class CardToken < Resource
      attr_reader :id, :status, :card_id, :last_digits, :cardholder, :extras

      def initialize(client, id:, **extras)
        @client = client
        @id = id
        process_hash(extras) if extras
      end

      def create(payload)
        response = @client.call(:card_tokens, :create, payload)
        if response.key?(:error)
          response
        else
          process_hash(response)
          self
        end
      end

      def retrieve
        response = @client.call(:card_tokens, :retrieve, { id: id })
        if response.key?(:error)
          response
        else
          process_hash(response)
          self
        end
      end

      def update(payload)
        response = @client.call(:card_tokens, :update, payload)
        if response.key?(:error)
          response
        else
          process_hash(response)
          self
        end
      end

      private

      def attr_inspect
        [:id, :last_digits, :card_id]
      end

      def process_hash(data)
        @status = data.delete(:status)
        @card_id = data.delete(:card_id)
        @last_digits = data.delete(:last_four_digits)
        @cardholder = data.delete(:cardholder)
        @extras = data
      end
    end
  end
end
