# frozen_string_literal: true

require "dice_bag/dice_bag_file"
require "dice_bag/project"

require "fileutils"
require "tempfile"

# This file encapsulate the template files Dicebag brings with itself
module DiceBag
  class DefaultTemplateFile
    include DiceBagFile

    def initialize(name, location = nil, save_as = nil)
      # if called from command line with only a name we search in all our templates for the file
      name = AvailableTemplates.template_filename_for(name) if File.dirname(name) == "."
      @filename = File.basename(save_as || name)
      @file = name
      @template_location = location
      @destination = File.join(Project.root, @template_location, @filename)
    end
  end
end
