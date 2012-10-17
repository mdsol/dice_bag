require 'dice_bag/github'

desc "Configure and run continuous integration tests then clean up"
task :ci => ['ci:status:pending'] do
  begin
    Rake::Task["ci:config"].invoke
    Rake::Task["ci:run"].invoke
    Rake::Task["ci:status:success"].invoke
  rescue
    Rake::Task["ci:status:failure"].invoke
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

  namespace :status do

    config = DiceBag::Configuration.new

    task :pending do
      DiceBag::GitHub.update_commit_status('pending', config)
    end
    task :success do
      DiceBag::GitHub.update_commit_status('success', config)
    end
    task :failure do
      DiceBag::GitHub.update_commit_status('failure', config)
    end
  end
end

