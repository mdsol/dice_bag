desc "Configure and run continuous integration tests then clean up"
task :ci do
  begin
    Rake::Task["ci:config"].invoke
    Rake::Task["ci:run"].invoke
  ensure
    Rake::Task["ci:clean"].invoke
  end
end

namespace :ci do

  desc "Configure the app to run continuous integration tests"
  # Could depend on 'db:schema:load' or 'db:setup' here instead of 'db:migrate'
  # if the 'db/schema.rb' file was commited to the repo (as per Rails
  # recommendations).
  task :config => ['ci:env', 'config:all', 'db:create', 'db:migrate']

  desc "Run continuous integration tests with the current configuration"
  task :run => ['ci:env', 'ci:shamus', 'ci:brakeman']

  desc "Destroy resources created externally for the continuous integration run, e.g. drops databases"
  task :clean => ['ci:env', 'db:drop']

  task :env do
    ENV['RAILS_ENV'] ||= 'test'
  end

  task :shamus do
    sh('bundle exec shamus')
  end

  task :brakeman do
    # Make warnings fail the build with the '--exit-on-warn' switch.
    sh('bundle exec brakeman --quiet --exit-on-warn')
  end
end

