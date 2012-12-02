#This class encapsulate data about the project dice_bag got in
module DiceBag

  class Project

    def self.name
      #TODO: how to do find the name of the project in no-rails environments?
      defined?(Rails) ? Rails.application.class.parent_name.downcase : 'project'
    end

    def self.file_in_config_dir(filename)
      filename = File.basename(filename)
      # Dir.pwd is the directory that contains the Rakefile. 
      # We may want to make this more general in the future
      File.join(Dir.pwd, 'config', filename)
    end

    #local templates always takes preference over generated templates
    def self.templates_to_generate
      generated_templates = Dir[Project.file_in_config_dir("**/*.erb")]
      custom_templates = Dir[Project.file_in_config_dir("**/*.erb.local")]
      all_files = generated_templates + custom_templates
      templates = all_files.delete_if {|file| custom_templates.include?(File.basename(file) + '.local') }
      templates.map{|t| File.basename(t)}
    end
  end
end
