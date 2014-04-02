Feature: Ignore configuration files in bundled gems

  Bundler may be used to install dependent gems that include their own
  Dice Bag configuration files. It's also possible that these gems may
  be installed in a local directory such as './vendor/bundle'. In these
  circumstances, we should ignore any Dice Bag configuration files in
  that local directory.

  #@disable-bundler

  @announce
  @original-bundler-environment
  Scenario: Ignoring files in the bundle path
    Given a file named ".bundle/config" with:
      """
      ---
      BUNDLE_PATH: excluded-bundled-gems
      """
    And an empty file named "excluded-bundled-gems/subdir/config.yml.dice"
    When I run `bundle exec rake config`
    Then a file named "excluded-bundled-gems/subdir/config.yml" should not exist
