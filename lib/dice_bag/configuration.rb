module DiceBag
  # This class abstracts access to configuration values, to be used within ERB
  # templates. Currently, the values are read from the environment, as per the
  # Twelve-Factor App principles.
  class Configuration
    def initialize
      @prefixed = {}
    end

    # Returns a Configuration::PrefixedWithFallback using the given +prefix+.
    #
    def [](prefix)
      @prefixed[prefix] ||= PrefixedWithFallback.new(prefix, self)
    end

    def method_missing(name)
      if name.to_s.end_with?("!")
        ensured_in_production(name)
      else
        ENV[name.to_s.upcase]
      end
    end

    private

    def ensured_in_production(name)
      variable_name = name.to_s.chomp("!").upcase
      value = ENV[variable_name]
      if in_production? && value.nil?
        raise "Environment variable #{variable_name} required in production but it was not provided"
      end
      value
    end

    def in_production?
      (defined?(Rails) && Rails.env.production?) ||
        (defined?(Sinatra) && Sinatra::Application.production?) ||
        ENV["RACK_ENV"] == "production"
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
        ENV["#{@prefix}_#{name.to_s.upcase}"] || @fallback.send(name)
      end
    end
  end
end
