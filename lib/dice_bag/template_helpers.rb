module DiceBag
  module TemplateHelpers
    def generate_private_key
      require 'openssl'
      OpenSSL::PKey::RSA.generate(2048)
    end
  end
end
