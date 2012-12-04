require 'dice_bag/dice_bag_file.rb'
require 'dice_bag/template_helpers'
require 'dice_bag/configuration'

#this class encapsulates the template files we will generate in the project 
#using this gem
module DiceBag

  class TemplateFile
    include DiceBagFile

    # Methods from this module need to be called directly from within the ERB
    # templates.
    include DiceBag::TemplateHelpers

    def initialize(name)
      @filename = name
      @file = Project.file_in_config_dir(name)
    end

    def create_file(config_file)
      # By passing "<>" we're trimming trailing newlines on lines that are
      # nothing but ERB blocks (see documentation). This is useful for files
      # like mauth_key where we want to control newlines carefully.
      template = ERB.new(File.read(@file), nil, "<>")

      #templates expect a configured object
      configured = Configuration.new
      contents = template.result(binding)

      return unless config_file.should_write?(contents)
      config_file.write(contents)
      puts "file config/#{config_file.filename} created"
    end

  end
end
