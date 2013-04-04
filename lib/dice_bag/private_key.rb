module DiceBag
  class PrivateKey

    attr_accessor :private_key

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
      parts = @private_key.split(/\s+/)
    	header = []
    	while parts.first !~ /-\Z/ && parts.any?
      	header << parts.shift
    	end
    	header << parts.shift
    	body = []
    	while parts.first !~ /\A-/ && parts.any?
      	body << parts.shift
    	end
    	footer = parts
    	@private_key = [header.join(" "), body, footer.join(" ")].flatten.join("\n")
    end

  end
end