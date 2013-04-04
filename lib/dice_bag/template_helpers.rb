require 'dice_bag/private_key'

module DiceBag
  module TemplateHelpers
    def generate_private_key
      require 'openssl'
      OpenSSL::PKey::RSA.generate(2048)
    end

    def ensure_is_private_key(key)
    	pkey = PrivateKey.new key
      pkey.to_rsa_format!
      if pkey.is_valid_private_key? 
        pkey.private_key
      else
        raise "The private key provided is invalid"
      end
    end

  end
end
