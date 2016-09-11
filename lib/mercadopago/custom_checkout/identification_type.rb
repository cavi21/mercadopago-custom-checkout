module MercadoPago
  module CustomCheckout
    class IdentificationType < Resource
      attr_reader :id, :name, :extras

      def initialize(id:, name:, **extras)
        @id = id
        @name = name
        @extras = extras
      end

      private

      def attr_inspect
        [:id, :name, :status]
      end
    end
  end
end
