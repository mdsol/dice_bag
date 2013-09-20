require 'erb'
require 'dice_bag/command'

desc "Populate all templates using values from the environment to create configuration files"
task :config => ['config:all']

namespace :config do
  # Deprecated, present only for backward compatibility.
  task :all do
    DiceBag::Command.new.write_all
  end

  desc "As per the config task but automatically overwrites pre-existing configuration files"
  task :deploy do
    DiceBag::Command.new.write_all(:deploy => true)
  end

  desc "Populate just the specified template to create the associated configuration file"
  task :file, :filename do |t, args|
    filename = args[:filename]
    raise "A filename needs to be provided" if filename.nil?
    DiceBag::Command.new.write(filename)
  end

  desc "Generate all configuration file templates needed by this project"
  task :generate_all do
    DiceBag::Command.new.generate_all_templates
  end

  desc "Generate just the specified template, optionally in the specified location"
  task :generate, :filename, :location do |t, args|
    filename = args[:filename]
    location = args[:location]
    raise "A filename needs to be provided" if filename.nil?
    DiceBag::Command.new.generate_template(DiceBag::DefaultTemplateFile.new(filename,location))
  end
end
