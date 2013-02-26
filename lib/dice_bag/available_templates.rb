require 'dice_bag/default_template_file'

# This class returns all the templates we can generate in this particular project
module DiceBag
 
  class AvailableTemplates


    # By default the final location for any template will be the config directory.
    # If any template 'plugin' wants to overwrite the directory where its template will be written
    # it needs to overwrite this method and return a string with the new location as relative
    # path inside the project.
    def templates_location
      Project.config_dir
    end

    class << self

      def template_checkers
        @template_checkers ||= []
      end

      def inherited(base)
        template_checkers << base
      end

      def all
        #all the classes than inherit from us in the ruby runtime
        available_templates = []

        template_checkers.each do |template_checker|
          checker = template_checker.new
          location = checker.templates_location
          checker.templates.each do |template|
            available_templates.push( DefaultTemplateFile.new(template, location) )
          end
        end
        available_templates
      end

      def template_filename_for(filename)
        self.all.each do |template|
          if template.filename.include? filename
            return template.file
          end
        end
      end
    end

  end

end


# we require the our own templates checker here, for other gems we just need 
# them to inherit from DiceBag::AvailableTemplates and require the file 
# If Ruby loads the file we can find the class in the object space and call it
require_relative 'templates/gems_checker'
