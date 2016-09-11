module MercadoPago
  module CustomCheckout
    class Resource

      def inspect
        formatted_attrs = attr_inspect.map do |attr|
          "#{attr}: #{send(attr).inspect}"
        end
        "#<#{self.class.name} #{formatted_attrs.join(", ")}>"
      end

    end
  end
end
