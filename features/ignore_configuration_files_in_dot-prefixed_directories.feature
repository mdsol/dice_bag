Feature: Ignore configuration files in dot-prefixed directories

  Directories prefixed by a dot are usually intended to hold configuration
  for applications used to inspect or manage the environment, rather than
  for the application installed in that location. We should ignore any Dice
  Bag configuration files in dot-prefixed directories.

  Scenario: Ignoring files in dot-prefixed directories
    Given an empty file named ".subdir/config.yml.dice"
    When I run `bundle exec rake config`
    Then a file named ".subdir/config.yml" should not exist
