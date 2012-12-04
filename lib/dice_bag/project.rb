#This class encapsulate data about the project dice_bag got in
module DiceBag

  class Project

    DEFAULT_NAME = 'project'
    def self.name
      #TODO: how to do find the name of the project in no-rails environments?
      defined?(Rails) ? Rails.application.class.parent_name.downcase : DEFAULT_NAME
    end

    def self.file_in_config_dir(filename)
      filename = File.basename(filename)
      # Dir.pwd is the directory that contains the Rakefile. 
      # We may want to make this more general in the future
      File.join(Dir.pwd, 'config', filename)
    end

    #local templates always takes preference over generated templates
    def self.templates_to_generate
      generated_templates = Dir[Project.file_in_config_dir("**/*.erb")]
      custom_templates = Dir[Project.file_in_config_dir("**/*.erb.local")]
      all_files = generated_templates + custom_templates
      templates = all_files.delete_if {|file| custom_templates.include?(File.basename(file) + '.local') }
      templates.map{|t| File.basename(t)}
    end

    #These two methods may not really below here but is relatively the best place for them
    def self.should_write?(file, new_contents)
      #we always overwrite if we are inside an script or we are not development
      return true if @force || !$stdin.tty? || ENV['RAILS_ENV'] == 'test' || ENV['RAILS_ENV'] == 'production'
      return true if !File.exists?(file)
      return false if self.diff(file, new_contents).empty?

      while true
        puts "Overwrite #{file} ?    Recommended: Yes. "
        puts " [Y]es, [n]o, [a]ll files, [q]uit, [d]show diff"
        answer = $stdin.gets.tap{|text| text.strip!.downcase! if text}
        case answer
        when 'y'
          return true
        when 'n'
          return false
        when 'a'
          return @force = true
        when 'q'
          exit
        when 'd'
          puts self.diff(file, new_contents)
        else
          return true
        end
      end
    end

    def self.diff(destination, content)
      diff_cmd = ENV['RAILS_DIFF'] || 'diff -u'
      Tempfile.open(File.basename(destination), File.dirname(destination)) do |temp|
        temp.write content
        temp.rewind
        `#{diff_cmd} #{destination} #{temp.path}`.strip
      end
    end

  end
end
