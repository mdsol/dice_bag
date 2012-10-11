require 'dice_bag/template_helpers'

module DiceBag

  # This class abstracts access to configuration values, to be used within ERB
  # templates. Currently, the values are read from the environment, as per the
  # Twelve-Factor App principles.
  #
  class Configuration

    # Methods from this module need to be called directly from within the ERB
    # templates.
    extend DiceBag::TemplateHelpers

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

    def self.write(template_name)
      template_filename = File.join(Rails.root, "config/#{template_name}.erb")
      config_filename = File.join(Rails.root, "config/#{template_name}")

      unless File.exists?(template_filename)
        fail "Template file '#{template_filename}' must exist to run this task"
      end

      # By passing "<>" we're trimming trailing newlines on lines that are
      # nothing but ERB blocks (see documentation). This is useful for files
      # like mauth_key where we want to control newlines carefully.
      template = ERB.new(File.read(template_filename), nil, "<>")

      configured = Configuration.new
      File.open(config_filename, 'w') {|file| file.puts(template.result(binding)) }
    end
  end
end
