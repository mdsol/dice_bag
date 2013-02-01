#This class encapsulate data about the project dice_bag got in
module DiceBag

  class Project

    DEFAULT_NAME = 'project'
    def self.name
      #TODO: how to do find the name of the project in no-rails environments?
      defined?(Rails) ? Rails.application.class.parent_name.downcase : DEFAULT_NAME
    end

    def self.config_files(filename)
      File.join(Dir.pwd, filename)
    end

    #local templates always takes preference over generated templates
    def self.templates_to_generate
      generated_templates = Dir[Project.config_files("**/config/*.erb")]
      custom_templates = Dir[Project.config_files("**/config/*.erb.local")]
      dotNetTemplates = Dir[Project.config_files("**/*.config.template")]
      all_files = generated_templates + custom_templates
      templates = all_files.delete_if {|file| custom_templates.include?(file + '.local')}
      dotNetTemplates = dotNetTemplates.delete_if {|file| file.include?("/bin/")}
      all_files + dotNetTemplates
    end
  end
end
