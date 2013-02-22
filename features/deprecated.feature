Feature: Deprecated

  The following functionality is deprecated.

  Background:
    Given a file named "Rakefile" with:
      """
      require 'dice_bag/tasks'
      """

  Scenario Outline: Using deprecated extensions
    Given a file named "<template file>" with:
      """
      <%= 1 + 2 %>
      """
    When I run `rake config`
    Then the file "<config file>" should contain:
      """
      3
      """

    Examples:
      | template file        | config file |
      | test.erb             | test        |
      | test.erb.local       | test        |
      | test.config.template | test.config |

