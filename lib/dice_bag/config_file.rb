# frozen_string_literal: true

require "dice_bag/dice_bag_file"
require "dice_bag/project"

# this class encapsulate a configuration file of the project
module DiceBag
  class ConfigFile
    include DiceBagFile

    def initialize(name)
      # The 'local', 'erb', and 'template' file extension are deprecated and
      # will be removed some time prior to v1.
      @filename = name.gsub(".local", "").gsub(".erb", "").gsub(".template", "").gsub(".dice", "")
      @file = Project.config_files(@filename)
    end
  end
end
