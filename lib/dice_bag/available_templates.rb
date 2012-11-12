# This class returns all the templates we can generate in this particular project
# It can read directories with templates.
# These directories are self-contained, they contain both the templates and the 
# code that decide if the templates should be generated for this project
module DiceBag
  class AvailableTemplates
    @@available = []

    def self.all
      self.read_dir(File.join(File.dirname(__FILE__), "templates/"))
      @@available
    end

    def self.add(filename)
      @@available.push(filename) 
      @@available.flatten.uniq
    end

    def self.read_dir(dirname)
      gem_file = File.join(dirname, 'gems_checker.rb')
      require gem_file
      DiceBag::needed_templates.each do |template|
        filename = File.join(dirname, template)
        self.add( filename )
      end
    end

  end
end

