require 'erb'
require 'dice_bag/configuration'

desc "Configure the application from the environment"
task :config => 'config:all'

namespace :config do
  # This is an alias for plain 'config' that can be called unabiguously from
  # within other namespaces.
  desc "creates all the files from their templates in config/"
  task :all  do 
    DiceBag::Configuration.write_all
  end

  desc "recreates the file passed as parameter from its template"
  task :file, :filename do |t, args|
    filename = args[:filename]
    raise "A filename needs to be provided" if filename.nil?
    DiceBag::Configuration.write(filename)
  end

end
