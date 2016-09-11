module MercadoPago
  module CustomCheckout
    class CardIssuer < Resource
      attr_reader :id, :name, :thumb, :extras

      def initialize(id:, name:, secure_thumbnail:, **extras)
        @id = id
        @name = name
        @thumb = secure_thumbnail
        @extras = extras
      end

      private

      def attr_inspect
        [:id, :name]
      end
    end
  end
end
