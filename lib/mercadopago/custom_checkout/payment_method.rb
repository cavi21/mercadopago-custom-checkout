module MercadoPago
  module CustomCheckout
    class PaymentMethod < Resource
      attr_reader :id, :name, :status, :thumb, :extras

      def initialize(account, id:, name:, status:, **extras)
        @account = account
        @id = id.to_sym
        @name = name
        @status = status
        @thumb = extras[:secure_thumbnail]
        @extras = extras
      end

      def card_issuers
        return @card_issuers unless @card_issuers.nil? || @card_issuers.empty?

        if (response = @account.card_issuers_for(@id)).is_a?(Array)
          @card_issuers = response
        end
      end

      def installments
        return @installments unless @installments.nil? || @installments.empty?

        if (response = @account.installments_for(@id)).is_a?(Array)
          @installments = response
        end
      end

      def bin
        extras[:settings][0] && extras[:settings][0][:bin]
      end

      private

      def attr_inspect
        [:id, :name, :status]
      end
    end
  end
end
