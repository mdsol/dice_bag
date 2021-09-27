# frozen_string_literal: true

require "dice_bag/private_key"

module DiceBag
  module TemplateHelpers
    def generate_private_key
      require "openssl"
      OpenSSL::PKey::RSA.generate(2048)
    end

    def ensure_is_private_key(key)
      pkey = PrivateKey.new key.dup
      pkey.to_rsa_format!

      if pkey.valid_private_key?
        pkey.private_key
      else
        raise "The private key provided is invalid"
      end
    end

    # Generates https://en.wikipedia.org/wiki/X.509 certificate, commonly used in authentication services
    def generate_509_certificate(private_key, root_ca: nil, root_key: nil)
      root_key ||= OpenSSL::PKey::RSA.new(2048) # the CA's public/private key
      root_ca ||= default_root_ca(root_key)

      cert = OpenSSL::X509::Certificate.new
      cert.version = 2
      cert.serial = 2
      cert.subject = OpenSSL::X509::Name.parse("/DC=org/DC=ruby-lang/CN=Ruby certificate")
      cert.issuer = root_ca.subject # root CA is the issuer
      cert.public_key = PrivateKey.new(private_key.dup).public_key
      cert.not_before = Time.now
      cert.not_after = cert.not_before + (1 * 365 * 24 * 60 * 60) # 1 years validity
      ef = OpenSSL::X509::ExtensionFactory.new
      ef.subject_certificate = cert
      ef.issuer_certificate = root_ca
      cert.add_extension(ef.create_extension("keyUsage", "digitalSignature", true))
      cert.add_extension(ef.create_extension("subjectKeyIdentifier", "hash", false))
      cert.sign(root_key, OpenSSL::Digest.new("SHA256"))
      cert
    end

    # raw_cert: DER or PEM encoded certificate
    def ensure_is_509_certificate(raw_cert)
      certificate = OpenSSL::X509::Certificate.new(raw_cert)
    rescue OpenSSL::X509::CertificateError
      false
    end

    def default_root_ca(root_key)
      @default_root_ca ||= generate_root_ca(root_key)
    end

    def generate_root_ca(root_key)
      root_ca = OpenSSL::X509::Certificate.new
      root_ca.version = 2 # cf. RFC 5280 - to make it a "v3" certificate
      root_ca.serial = 1 # considered a security flaw for real certificates
      root_ca.subject = OpenSSL::X509::Name.parse("/DC=org/DC=ruby-lang/CN=Ruby CA")
      root_ca.issuer = root_ca.subject # root CA's are "self-signed"
      root_ca.public_key = root_key.public_key
      root_ca.not_before = Time.now
      root_ca.not_after = root_ca.not_before + (2 * 365 * 24 * 60 * 60) # 2 years validity
      ef = OpenSSL::X509::ExtensionFactory.new
      ef.subject_certificate = root_ca
      ef.issuer_certificate = root_ca
      root_ca.add_extension(ef.create_extension("basicConstraints", "CA:TRUE", true))
      root_ca.add_extension(ef.create_extension("keyUsage", "keyCertSign, cRLSign", true))
      root_ca.add_extension(ef.create_extension("subjectKeyIdentifier", "hash", false))
      root_ca.add_extension(ef.create_extension("authorityKeyIdentifier", "keyid:always", false))
      root_ca.sign(root_key, OpenSSL::Digest.new("SHA256"))
    end
  end
end
