Feature: Ignore configuration files in bundled gems

  Bundler may be used to install dependent gems that include their own
  Dice Bag configuration files. It's also possible that these gems may
  be installed in a local directory such as './vendor/bundle'. In these
  circumstances, we should ignore any Dice Bag configuration files in
  that local directory.

  @clean-bundler-environment
  Scenario: Ignoring files in the bundle path
    Given The default aruba timeout is 15 seconds
    And a Gemfile with dice_bag as a dependency
    And an empty file named "excluded-bundled-gems/subdir/config.yml.dice"
    When I run `bundle install --path=excluded-bundled-gems`
    And I run `bundle exec rake config`
    Then a file named "excluded-bundled-gems/subdir/config.yml" should not exist

  @clean-bundler-environment
  Scenario: Not ignoring files outside the bundle path
    Given The default aruba timeout is 15 seconds
    And a Gemfile with dice_bag as a dependency
    And an empty file named "subdir/config.yml.dice"
    When I run `bundle install --path=excluded-bundled-gems`
    And I run `bundle exec rake config`
    Then a file named "subdir/config.yml" should exist
