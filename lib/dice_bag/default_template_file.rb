require 'dice_bag/dice_bag_file'
require 'dice_bag/project'

require 'tempfile'

#This file encapsulate the template files Dicebag brings with itself
module DiceBag

  class DefaultTemplateFile
    include DiceBagFile

    def initialize(name)
      #if called from command line with only a name we search in all our templates for the file
      if (File.dirname(name) == '.')
        name = AvailableTemplates.template_filename_for(name)
      end
      @filename = File.basename(name)
      @file = name
    end

    def create_file(template_file)
      contents = read_template(@file)
      template_file.write(contents)
      puts "new template file generated in config/#{template_file.filename}. 
            execute 'rake config:all' to get the corresponding configuration file."
    end

    def read_template(template)
      # Some templates need the name of the project. We put a placeholder
      # PROJECT_NAME there, it gets substituted by the real name of the project here
      File.readlines(template).join.gsub("PROJECT_NAME", Project.name)
    end
  end
end
