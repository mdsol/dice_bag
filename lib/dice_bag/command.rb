require 'dice_bag/configuration'
require 'dice_bag/template_helpers'
require 'dice_bag/available_templates'
require 'tempfile'

module DiceBag
  #This class seems a candidate to be converted to Thor, the problem is that we need to run
  #in the same process than the rake task so all the gems are loaded before dice_bag
  #is called and dice_bag can find what software is used in this project
  class Command

    # Methods from this module need to be called directly from within the ERB
    # templates.
    include DiceBag::TemplateHelpers

    attr_accessor :force

    def initialize
      @force = false
    end

    def write_all
      templates_to_generate.each do |template|
        file_name = File.basename(template)
        write(file_name)
      end
    end

    def write(template_name)

      config_name = template_name.gsub('.local', '').gsub('.erb', '')

      template_filename = file_in_config_dir(template_name)
      new_config_filename = file_in_config_dir(config_name)

      unless File.exists?(template_filename)
        raise "template file #{template_name} not found. Configuration file not created"
      end

      # By passing "<>" we're trimming trailing newlines on lines that are
      # nothing but ERB blocks (see documentation). This is useful for files
      # like mauth_key where we want to control newlines carefully.
      template = ERB.new(File.read(template_filename), nil, "<>")

      #templates expect a configured object
      configured = Configuration.new

      contents = template.result(binding)
      File.open(new_config_filename, 'w') {|file| file.puts(contents) }
      puts "file config/#{config_name} created"

    end

    def generate_all_templates
      AvailableTemplates.all.each do |template|
        generate_template(template)
      end
    end

    def generate_template(file)
      unless File.exists?(file)
        raise "template file #{file} not found, template not generated"
      end

      config_filename = File.basename(file)
      new_template_filename = file_in_config_dir(config_filename)

      contents = read_template(file)

   #   if should_write?(new_template_filename, contents)
      File.open(new_template_filename, 'w') {|template| template.puts(contents) }
      puts "new template file generated in config/#{config_filename}. execute 'rake config:all' to get the corresponding configuration file."
   #   end
    end


    private
    #local templates always takes preference over generated templates
    def templates_to_generate
      generated_templates = Dir[file_in_config_dir("**/*.erb")]
      custom_templates = Dir[file_in_config_dir("**/*.erb.local")]
      all_files = generated_templates + custom_templates
      all_files.delete_if {|file| custom_templates.include?(File.basename(file) + '.local') }
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

    def read_template(template)
      # Some templates need the name of the project. We put a placeholder
      # PROJECT_NAME there, it gets substituted by the real name of the project here
      File.readlines(template).join.gsub("PROJECT_NAME", project_name)
    end

    def project_name
      #TODO: how to do find the name of the project in no-rails environments?
      defined?(Rails) ? Rails.application.class.parent_name.downcase : 'project'
    end

    def file_in_config_dir(filename)
      filename = File.basename(filename)
      # Dir.pwd is the directory that contains the Rakefile. 
      # We may want to make this more general in the future
      File.join(Dir.pwd, 'config', filename)
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
