require 'dice_bag/dice_bag_file'
require 'dice_bag/project'

require 'tempfile'

#This file encapsulate the template files Dicebag brings with itself
module DiceBag

  class DefaultTemplateFile
    include DiceBagFile

    def initialize(name)
      @filename = File.basename(name)
      @file = name
    end

    def create_file(template_file)
      contents = read_template(@file)
   #  if should_write?(template_file.file, contents)
      template_file.write(contents)
      #end
    end

    def read_template(template)
      # Some templates need the name of the project. We put a placeholder
      # PROJECT_NAME there, it gets substituted by the real name of the project here
      File.readlines(template).join.gsub("PROJECT_NAME", Project.name)
    end

    def should_write?(file, new_contents)
      #we always overwrite if we pass force as param, are inside an script or we are not development
      return true if force || !$stdin.tty? || ENV['RAILS_ENV'] == 'test' || ENV['RAILS_ENV'] == 'production'
      return true if !File.exists?(file)
      return false if diff(file, new_contents).empty?

      while true
        puts "Overwrite? Recommended: Yes.  #{file}, [Y]es, [n]o, [a]ll files, [q]uit, [d]show diff"
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
          puts diff(file, new_contents)
        else
          return true
        end
      end
    end

    def diff(destination, content)
      diff_cmd = ENV['RAILS_DIFF'] || 'diff -u'
      Tempfile.open(File.basename(destination), File.dirname(destination)) do |temp|
        temp.write content
        temp.rewind
        `#{diff_cmd} #{destination} #{temp.path}`.strip
      end
    end

  end
end
