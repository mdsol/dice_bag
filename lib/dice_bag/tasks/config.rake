require 'erb'
require 'dice_bag/command'

desc "Configure the application from the environment. It creates template files if you need and their config files"
task :config => ['config:generate_all', 'config:all']

namespace :config do
  desc "Create all the files from their templates in config/"
  task :all do
    DiceBag::Command.new.write_all
  end

  desc "Recreate the file passed as parameter from its template"
  task :file, :filename do |t, args|
    filename = args[:filename]
    raise "A filename needs to be provided" if filename.nil?
    DiceBag::Command.new.write(filename)
  end

  desc "Generates all the template files needed by this project, named as the parameter."
  task :generate_all do
    DiceBag::Command.new.generate_all_templates
  end

  desc "Regenerate a given template"
  task :generate, :filename do |t, args|
    filename = args[:filename]
    raise "A filename needs to be provided" if filename.nil?
    DiceBag::Command.new.generate_template(filename)
  end

  desc "Ovewrites both your templates and configuration files with the defaults of dice bag."
  task :overwrite do
    executor = DiceBag::Command.new
    executor.force = true
    executor.generate_all_templates
    executor.write_all
  end
end
