module DiceBag
  class PrivateKey
    attr_accessor :private_key

    def initialize(key)
      @private_key = key
    end

    def valid_private_key?
      require "openssl"

      begin
        OpenSSL::PKey::RSA.new @private_key
        true
      rescue => e
        puts "#{e.message}\n#{e.backtrace}"
        false
      end
    end

    def to_rsa_format!
      strip_down_key
      body = @private_key.split(/\s+/)
      body = body.first.scan(/.{1,64}/) if body.length == 1
      @private_key = [HEADER, body, FOOTER].flatten.join("\n")
    end

    private

    HEADER = "-----BEGIN RSA PRIVATE KEY-----".freeze
    FOOTER = "-----END RSA PRIVATE KEY-----".freeze

    def strip_down_key
      @private_key.gsub!(HEADER, "")
      @private_key.gsub!(FOOTER, "")
      @private_key.strip!
    end
  end
end
