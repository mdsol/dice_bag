require 'dice_bag/dice_bag_file.rb'
require 'dice_bag/project'

#this class encapsulate a configuration file of the project
module DiceBag

  class ConfigFile
    include DiceBagFile
    def initialize(name)
      @filename = name.gsub('.local', '').gsub('.erb', '')
      @file = Project.file_in_config_dir(name)
    end
  end
end
