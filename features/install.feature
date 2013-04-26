Feature: Install

  In Rails projects, DiceBag tasks are loaded automatically. For other
  projects, add `require 'dice_bag/tasks'` to your `Rakefile` or wherever your
  local rake tasks are defined.

  Scenario: Require DiceBag tasks in Rakefile
    Given a file named "Rakefile" with:
      """
      require 'dice_bag/tasks'
      """
    When I run `rake config`
    Then the exit status should be 0
