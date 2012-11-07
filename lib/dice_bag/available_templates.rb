
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

