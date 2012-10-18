require 'net/https'

module DiceBag

  # This module abstracts access to GitHub. It's current purpose is solely to
  # allow commit statuses to be updated.
  #
  # See: https://github.com/blog/1227-commit-status-api
  #
  module GitHub
    extend self

    # Update the commit status for the current HEAD commit. Assumes the working
    # directory is a git repo and the "origin" remote points to a GitHub repo.
    # The +state+ variable must be one of :pending, :success or :failure. The
    # +config+ object must respond to +build_number+, +build_url+ and
    # +github_auth_token+.
    #
    def update_commit_status(state, config)

      # TODO: Refactor the following code to use gems like git/grit/rugged and
      # octokit. The reason this code does not do this currently is to avoid
      # introducing these gems as unnecessary dependencies for production
      # deployment, which is a target for Dice Bag. The plan is to split the CI
      # tasks out from this gem so they can pull in development and test
      # dependencies freely. ~asmith

      body = %Q({
        "state": "#{state.to_s}",
        "target_url": "#{config.build_url}",
        "description": "Continuous integration run #{config.build_number}"
      })
      commit = `git log -1 --format=format:%H`
      remotes = `git remote --verbose`

      unless repo = /^origin\s+git@github.com:(\w+\/\w+)\b/.match(remotes)[1]
        put "Could not establish GitHub repo name from 'origin' remote"
        return
      end

      uri = URI("https://api.github.com/repos/#{repo}/statuses/#{commit}?access_token=#{config.github_auth_token}")

      if config.github_auth_token
        puts "Setting #{repo} commit #{commit} status to '#{state}' on GitHub"
      else
        puts "Skipping setting #{repo} commit #{commit} status to '#{state}' on GitHub because access token not configured"
        return
      end

      Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        response = http.post(uri.request_uri, body)
        unless response.is_a?(Net::HTTPCreated)
          puts "Setting commit status FAILED", response
        end
      end
    end
  end
end

