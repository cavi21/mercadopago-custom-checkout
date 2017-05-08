# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mercadopago/custom_checkout/version"

Gem::Specification.new do |spec|
  spec.name          = "mercadopago-custom-checkout"
  spec.version       = MercadoPago::CustomCheckout::VERSION
  spec.authors       = ["Agustin Cavilliotti"]
  spec.email         = ["cavi21@gmail.com"]

  spec.summary       = "Client for the MercadoPago API"
  spec.description   = "Allow to interact withthe services available in the MercadoPago Custom Checkout API (https://www.mercadopago.com.ar/developers/en/api-docs/custom-checkout/authentication/)}"
  spec.homepage      = "https://github.com/cavi21/mercadopago-custom-checkout"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry"
  spec.add_development_dependency "httplog"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "faraday", [">= 0.8", "< 0.13"]
  spec.add_dependency "multi_json", "~> 1.3"
end
