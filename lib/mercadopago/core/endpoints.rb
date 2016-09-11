module MercadoPago
  module Core
    ENDPOINTS = {
      card_issuers: {
        retrieve: {
          endpoint: "/%{version}/payment_methods/card_issuers",
          method: :get,
          allowed_tokens: [:public_key]
        }
      },
      card_tokens: {
        create: {
          endpoint: "/%{version}/card_tokens",
          method: :post,
          allowed_tokens: [:public_key]
        },
        retrieve: {
          endpoint: "/%{version}/card_tokens/%{id}",
          method: :get,
          allowed_tokens: [:public_key]
        },
        update: {
          endpoint: "/%{version}/card_tokens/%{id}",
          method: :put,
          allowed_tokens: [:public_key]
        }
      },
      cards: {
        all: {
          endpoint: "/%{version}/customers/%{customer_id}/cards",
          method: :get,
          allowed_tokens: [:access_token]
        },
        create: {
          endpoint: "/%{version}/customers/%{customer_id}/cards",
          method: :post,
          allowed_tokens: [:access_token]
        },
        retrieve: {
          endpoint: "/%{version}/customers/%{customer_id}/cards/%{id}",
          method: :get,
          allowed_tokens: [:access_token]
        },
        update: {
          endpoint: "/%{version}/customers/%{customer_id}/cards/%{id}",
          method: :put,
          allowed_tokens: [:access_token]
        },
        delete: {
          endpoint: "/%{version}/customers/%{customer_id}/cards/%{id}",
          method: :delete,
          allowed_tokens: [:access_token]
        }
      },
      customers: {
        search: {
          endpoint: "/%{version}/customers/search",
          method: :get,
          allowed_tokens: [:access_token]
        },
        create: {
          endpoint: "/%{version}/customers",
          method: :post,
          allowed_tokens: [:access_token]
        },
        retrieve: {
          endpoint: "/%{version}/customers/%{id}",
          method: :get,
          allowed_tokens: [:access_token]
        },
        update: {
          endpoint: "/%{version}/customers/%{id}",
          method: :put,
          allowed_tokens: [:access_token]
        },
        delete: {
          endpoint: "/%{version}/customers/%{id}",
          method: :delete,
          allowed_tokens: [:access_token]
        }
      },
      identification_types:{
        retrieve: {
          endpoint: "/%{version}/identification_types",
          method: :get,
          allowed_tokens: [:public_key]
        }
      },
      installments:{
        retrieve: {
          endpoint: "/%{version}/payment_methods/installments",
          method: :get,
          allowed_tokens: [:public_key]
        }
      },
      payment_methods:{
        retrieve: {
          endpoint: "/%{version}/payment_methods",
          method: :get,
          allowed_tokens: [:public_key]
        }
      },
      payments: {
        search: {
          endpoint: "/%{version}/payments/search",
          method: :get,
          allowed_tokens: [:access_token]
        },
        create: {
          endpoint: "/%{version}/payments",
          method: :post,
          allowed_tokens: [:access_token]
        },
        retrieve: {
          endpoint: "/%{version}/payments/%{id}",
          method: :get,
          allowed_tokens: [:access_token]
        },
        update: {
          endpoint: "/%{version}/payments/%{id}",
          method: :put,
          allowed_tokens: [:access_token]
        }
      },
      users: {
        me: {
          endpoint: "/users/me",
          method: :get,
          allowed_tokens: [:access_token]
        }
      }
    }.freeze
  end
end
