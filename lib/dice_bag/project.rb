# frozen_string_literal: true

# This class encapsulate data about the project dice_bag got in
module DiceBag
  class Project
    DEFAULT_NAME = "project"
    DEFAULT_BUNDLE_PATH = "vendor/bundle"

    # TODO: how to find the name of the project in non Rails apps?
    def self.name
      return DEFAULT_NAME unless defined?(Rails)

      parent_name_method = Module.respond_to?(:module_parent_name) ? :module_parent_name : :parent_name
      Rails.application.class.send(parent_name_method).downcase
    end

    def self.config_files(filename)
      File.join(root, filename)
    end

    def self.root
      Dir.pwd
    end

    def self.templates_to_generate
      bundle_path = (defined?(Bundler) && Bundler.settings[:path]) || DEFAULT_BUNDLE_PATH
      FileList.new("**/*.dice") do |fl|
        fl.exclude(File.join(bundle_path, "/**/*"))
      end
    end
  end
end
