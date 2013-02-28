require 'dice_bag/dice_bag_file.rb'
require 'dice_bag/project'

#this class encapsulate a configuration file of the project
module DiceBag

  class ConfigFile
    include DiceBagFile
    def initialize(template_file)
      # The 'local', 'erb', and 'template' file extension are deprecated and
      # will be removed some time prior to v1.
      @filename = template_file.filename.gsub('.local', '').gsub('.erb', '').gsub('.template','').gsub('.dice', '')
      @file = File.join(File.dirname(template_file.file), @filename)
    end
  end
end
