require 'rubygems'
require 'dice_bag/default_template_file'

# This class returns all the templates we can generate in this particular project
module DiceBag

  class AvailableTemplates

    # By default the final location for any template will be the config directory.
    # If any template 'plugin' wants to overwrite the directory where its template will be written
    # it needs to overwrite this method and return a string with the new location as relative
    # path inside the project.
    def templates_location
      'config'
    end

    class << self

      def gem_specs
        @gem_specs ||= begin
          Gem::Specification.sort.each_with_object({}) do |spec, hsh|
            hsh[spec.name] = spec.full_gem_path
          end
        end
      end

      def checker_within_given_gems?(checker, gem_names)
        checker_file = checker.method(:templates).source_location[0]
        gem_specs.each do |name, location|
          return true if checker_file.starts_with?(location) && gem_names.include?(name)
        end
        false
      end

      def template_checkers
        @template_checkers ||= []
      end

      def inherited(base)
        template_checkers << base
      end

      def all(gem_names=[])
        #all the classes than inherit from us in the ruby runtime
        available_templates = []

        template_checkers.each do |template_checker|
          checker = template_checker.new
          next if !gem_names.empty? && !checker_within_given_gems?(checker, gem_names)
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


# we require our own templates checker here, for other gems we just need
# them to inherit from DiceBag::AvailableTemplates and require the file
# If Ruby loads the file we can find the class in the object space and call it
require_relative 'templates/gems_checker'
