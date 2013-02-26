Feature: Deprecated

  The following functionality is deprecated with the exeption of the use of
  the `.dice` extension, which is tested here to keep the Rails simulation
  jailed to this file.

  Scenario Outline: Deprecated extensions in Rails projects
    Given a file named "Rakefile" with:
      """
      require 'dice_bag/tasks'

      # Simulate Rails being present. This triggers processing of the 'config'
      # sub-directory. Not our finest moment.
      module Rails; end
      """
    And an empty file named "<template file>"
    When I run `rake config`
    Then a file named "<config file>" should exist

    Examples:
      | template file         | config file |
      | config/test.dice      | config/test |
      | config/test.erb       | config/test |
      | config/test.erb.local | config/test |

  Scenario: Deprecated extensions in non-Rails projects
    Given a file named "Rakefile" with:
      """
      require 'dice_bag/tasks'
      """
    And an empty file named "test.config.template"
    When I run `rake config`
    Then a file named "test.config" should exist

