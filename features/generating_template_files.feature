Feature: Generating template files
  
  Scenario: Generate standard template files
    Given a file named "Rakefile" with:
      """
      require 'dice_bag/tasks'

      # Simulate Mysql2 being present.
      module Mysql2; end
      """
    When I run `rake config:generate_all`
    Then a file named "config/database.yml.dice" should exist

  Scenario: Creating your own template provider
    Given a file named "Rakefile" with:
      """
      require 'dice_bag/tasks'
      require './my_templates/my_template'
      """
    And a file named "my_templates/my_template.rb" with:
      """
      class MyTemplateProvider < DiceBag::AvailableTemplates
        def templates
          # You can return an array with multiple templates here but in
          # this example we're returning just one.
          [File.join(File.dirname(__FILE__), 'my_template.yml.dice')]
        end
      end
      """
    And a file named "my_templates/my_template.yml.dice" with:
      """
      <%= 'My template!' %>
      """
    When I run `rake config:generate_all`
    Then the file "config/my_template.yml.dice" should contain:
      """
      <%= 'My template!' %>
      """

  Scenario: Providing templates for a directory other than 'config'
    Given a file named "Rakefile" with:
      """
      require 'dice_bag/tasks'
      require './my_templates/my_template'
      """
    And a file named "my_templates/my_template.rb" with:
      """
      class MyTemplateProvider < DiceBag::AvailableTemplates
        def templates
          [File.join(File.dirname(__FILE__), 'my_initializer.rb.dice')]
        end
        def templates_location
          File.join('config', 'initializers')
        end
      end
      """
    And an empty file named "my_templates/my_initializer.rb.dice"
    When I run `rake config:generate_all`
    Then a file named "config/initializers/my_initializer.rb.dice" should exist

