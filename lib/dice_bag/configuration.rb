require 'dice_bag/template_helpers'
require 'dice_bag/available_templates'

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

    def self.write_all
      template_names = File.join(DiceBag::configuration_dir, "**/*.erb")
      Dir[template_names].each do |template|
        file_name = template.split("config/").last.gsub('.erb', '')
        self.write(file_name)
      end
    end

    def self.write(template_name)
      
      template_filename = File.join(DiceBag::configuration_dir, "#{template_name}.erb")
      config_filename = File.join(DiceBag::configuration_dir, template_name)

      unless File.exists?(template_filename)
        raise "template file #{template_name}.erb not found. Configuration file not created"
      end

      # By passing "<>" we're trimming trailing newlines on lines that are
      # nothing but ERB blocks (see documentation). This is useful for files
      # like mauth_key where we want to control newlines carefully.
      template = ERB.new(File.read(template_filename), nil, "<>")

      configured = Configuration.new
      File.open(config_filename, 'w') {|file| file.puts(template.result(binding)) }
    end

    def self.generate_all_templates
      AvailableTemplates.all.each do |template|
        self.generate_template(template)
      end
    end

    def self.generate_template(file)
      unless File.exists?(file)
        raise "template file #{file} not found, template not generated"
      end

      filename = File.basename(file)
      new_config_file = File.join(DiceBag::configuration_dir, filename)
      unless File.exists?(new_config_file)
        DiceBag::copy_file(file, new_config_file)
        puts "new template file generated in config/#{filename}. execute 'rake config:all' to get your configuration file."
      end
    end

  end


  #utility methods used by the methods above, surely need to be moved somewhere else.
  
  def self.copy_file(src, dst)
    #TODO: how to do this in no-rails environments?
    project_name = Rails.application.class.parent_name.downcase
    File.open(dst,"w") do |output|
      output.puts File.readlines(src).join.gsub("PROJECT_NAME", project_name)
    end
  end

  #TODO: Find a better home for this method
  def self.configuration_dir
    # Dir.pwd is the directory that contains the Rakefile. 
    # We may want to make this more general in the future
    File.join(Dir.pwd, "config")
  end
end
