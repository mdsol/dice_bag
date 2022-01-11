# frozen_string_literal: true

require "dice_bag/dice_bag_file"
require "dice_bag/template_helpers"
require "dice_bag/configuration"
require "dice_bag/warning"

# This class encapsulates the template files we will generate in the project using this gem.
module DiceBag
  class TemplateFile
    include DiceBagFile

    # Methods from this module need to be called directly from within the ERB templates.
    include DiceBag::TemplateHelpers

    def initialize(name)
      @filename = File.basename(name)
      @file = Project.config_files(name)
    end

    def create_file(config_file, params)
      # templates expect a configured object
      configured = Configuration.new
      warning = Warning.new(@filename)
      contents = template.result(binding)

      return unless params[:deploy] || config_file.should_write?(contents)

      config_file.write(contents)
      puts "File '#{config_file.file}' created"
    end

    private

    def template
      # By passing "<>" we're trimming trailing newlines on lines that are
      # nothing but ERB blocks (see documentation). This is useful for files
      # like mauth_key where we want to control newlines carefully.
      if ERB.instance_method(:initialize).parameters.assoc(:key) # Ruby 2.6+
        ERB.new(File.read(@file), trim_mode: "<>")
      else
        ERB.new(File.read(@file), nil, "<>")
      end
    end
  end
end
