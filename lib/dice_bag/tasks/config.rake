require 'erb'
require 'dice_bag/command'

desc "Configure the application from the environment. It creates template files, config files and the database"
task :config => ['config:generate_all', 'config:all', 'config:db']

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

  desc "creates and setups the database of the project"
  task :db do
    db_tasks = ["db:create", "db:migrate"]
    all_tasks = Rake::Task.tasks.map(&:name)
    return unless (all_tasks & db_tasks) == db_tasks
    db_tasks.each do |task|
      Rake::Task[task].invoke
    end
  end

end
