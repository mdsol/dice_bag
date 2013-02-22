#This class encapsulate data about the project dice_bag got in
module DiceBag

  class Project

    DEFAULT_NAME = 'project'
    def self.name
      #TODO: how to do find the name of the project in no-rails environments?
      defined?(Rails) ? Rails.application.class.parent_name.downcase : DEFAULT_NAME
    end

    def self.config_files(filename)
      File.join(self.root, self.config_dir, filename)
    end

    # dotNet apps do not have the templates in config/ but in the root of the project
    # TODO: detect dotNet instead of detecting rails
    def self.config_dir
      defined?(Rails) ? 'config' : "."
    end

    def self.root
      Dir.pwd
    end

    #local templates always takes preference over generated templates
    def self.templates_to_generate
      dice_templates = Dir["**/*.dice"]

      # The following ways of identifying template files will be removed prior
      # to v1.
      generated_templates = Dir[Project.config_files("**/*.erb")]
      custom_templates = Dir[Project.config_files("**/*.erb.local")]
      dotNetTemplates = Dir[Project.config_files("**/*.config.template")]

      legacy_files = generated_templates + custom_templates + dotNetTemplates
      legacy_files.each do |file|
        $stderr.puts "DEPRECATION WARNING: Use '.dice' file extension instead for '#{file}'"
      end

      all_files = legacy_files + dice_templates

      cleaned_templates = all_files.delete_if {|file| custom_templates.include?(file + '.local')}
      dotNetTemplates = dotNetTemplates.delete_if {|file| file.include?("/bin/")}
      (cleaned_templates + dotNetTemplates).map { |template| File.basename(template) }
    end

  end
end
