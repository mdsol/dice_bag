module DiceBag
  class PrivateKey

    attr_accessor :private_key
    @@header = "-----BEGIN RSA PRIVATE KEY-----"
    @@footer = "-----END RSA PRIVATE KEY-----"

    def initialize(key)
      @private_key = key
    end

    def is_valid_private_key?
      require 'openssl'
      begin
        OpenSSL::PKey::RSA.new @private_key
        return true  
      rescue => e
        p e.message
        p e.backtrace
        return false
      end
    end 

    def to_rsa_format!
      strip_down_key
      body = @private_key.split(/\s+/)
      body = body.first.scan(/.{1,64}/) if body.length == 1
    	@private_key = [@@header, body, @@footer].flatten.join("\n")
    end

    private

    def strip_down_key
      @private_key.gsub!(@@header,"")
      @private_key.gsub!(@@footer,"")
      @private_key.strip!
    end

  end
end