#This class encapsulate data about the project dice_bag got in
module DiceBag

  class Project

    DEFAULT_NAME = 'project'
    def self.name
      #TODO: how to do find the name of the project in no-rails environments?
      defined?(Rails) ? Rails.application.class.parent_name.downcase : DEFAULT_NAME
    end

    def self.config_files(filename)
      File.join(self.root, filename)
    end

    def self.root
      Dir.pwd
    end

    def self.templates_to_generate
      Dir['**/*.dice']
    end
  end
end
