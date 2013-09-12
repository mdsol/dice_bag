require 'dice_bag/dice_bag_file'
require 'dice_bag/project'

require 'tempfile'

#This file encapsulate the template files Dicebag brings with itself
module DiceBag

  class DefaultTemplateFile
    include DiceBagFile

    def initialize(name, location=nil)
      #if called from command line with only a name we search in all our templates for the file
      if (File.dirname(name) == '.')
        name = AvailableTemplates.template_filename_for(name)
      end
      @filename = File.basename(name)
      @file = name
      @template_location = location
    end

    def create_file
      contents = read_template(@file)
      rooted_template_location = File.join(Project.root, @template_location)
      Dir.mkdir(rooted_template_location) unless Dir.exist?(rooted_template_location)
      template_file = File.join(rooted_template_location, @filename)
      File.open(template_file, 'w') do |file|
        file.puts(contents)
      end
      puts "new template file generated in #{template_file}.
            execute 'rake config:all' to get the corresponding configuration file."
    end

    def read_template(template)
      # Some templates need the name of the project. We put a placeholder
      # PROJECT_NAME there, it gets substituted by the real name of the project here
      File.readlines(template).join.gsub("PROJECT_NAME", Project.name)
    end
  end
end
