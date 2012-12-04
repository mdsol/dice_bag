module DiceBag

  # This class abstracts access to configuration values, to be used within ERB
  # templates. Currently, the values are read from the environment, as per the
  # Twelve-Factor App principles.
  class Configuration

    def initialize
      @prefixed = Hash.new
    end

    # Returns a Configuration::PrefixedWithFallback using the given +prefix+.
    #
    def [](prefix)
      @prefixed[prefix] ||= PrefixedWithFallback.new(prefix, self)
    end

    def method_missing(name)
      ENV[name.to_s.upcase]
    end

    # This class acts like +Configuration+ but with a prefix applied to the
    # environment variables used to provide values. This is useful for providing
    # per-environment overrides to value in Rails projects. If the prefixed
    # environment variable is not found, the class delegates to the provided
    # fallback Configuration class, without the prefix.
    #
    class PrefixedWithFallback
      def initialize(prefix, fallback)
        @prefix = prefix.to_s.upcase
        @fallback = fallback
      end

      def method_missing(name)
        ENV["#{ @prefix }_#{ name.to_s.upcase }"] || @fallback.send(name)
      end
    end
  end

end
