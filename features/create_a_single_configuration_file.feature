Feature: Create a single configuration file

  Sometimes you just want to reconfigure a single file, so the `config:file`
  task is there to help you out.

  Scenario: Populating a single configuration file
    Given an empty file named "database.yml.dice"
    And an empty file named "secret_token.rb.dice"
    When I run `rake config:file[database.yml.dice]`
    Then a file named "database.yml" should exist
    But a file named "secret_token.rb" should not exist

