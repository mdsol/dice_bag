require 'dice_bag/version'

# This module contains common methods for all the type of files Dicebag knows about:
# configuration files, templates files in the project an templates files shipped with dicebag
module DiceBag
  module DiceBagFile
    attr_reader :file, :filename
    @@overwrite_all = false

    def assert_existence
      unless File.exists?(@file)
        raise "File #{@file} not found. Configuration file not created"
      end
    end

    def write(contents)
      File.open(@file, 'w') do |file|
        file.puts(contents)
      end
    end

    def should_write?(new_contents)
      return true if @@overwrite_all || !File.exists?(file)
      return false if diff(file, new_contents).empty?

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
          return @@overwrite_all = true
        when 'q'
          exit
        when 'd'
          puts diff(file, new_contents)
        else
          return true
        end
      end
    end

    private
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
