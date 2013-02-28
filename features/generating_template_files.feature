Feature: Generating template files

  Background:
    Given a file named "Rakefile" with:
      """
      require 'dice_bag/tasks'

      # Simulate Mysql2 being present. Should really just describe how to build
      # a template provider here instead.
      module Mysql2; end
      """

  Scenario: Generate standard template files
    # That the directory needs to exist is a bug!
    Given a directory named "config"
    When I run `rake config:generate_all`
    Then a file named "config/database.yml.dice" should exist

