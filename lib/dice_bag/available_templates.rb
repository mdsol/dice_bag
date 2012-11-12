# This class returns all the templates we can generate in this particular project
module DiceBag
 
  class AvailableTemplates

    def self.all
      #all the classes than inherit from us in the ruby runtime
      template_checkers = ObjectSpace.each_object(Class).select { |klass| klass < self }
      available_templates = []

      template_checkers.each do |checker|
        checker.new.templates.each do |template|
          available_templates.push( template)
        end
      end
      available_templates
    end

  end
end

# we require the our own templates checker here, for other gems we just need 
# them to inherit from DiceBag::AvailableTemplates and require the file 
# If Ruby loads the file we can find the class in the object space and call it
require_relative 'templates/gems_checker'
