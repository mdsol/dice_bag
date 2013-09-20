Feature: Replacing existing configuration files

  For developers, we want to avoid replacing local configuration files
  accidentally. Therefore, we make the simplest `config` task be
  developer-friendly and prompt before replacing.

  For deployments, we should always replace, so that the configuration process
  is idempotent. The `config:deploy` task serves this need.

  Note: We experimented with detecting whether the task was running in a
  developer or deployment context and behaving as appropriate. However, this
  failed for a number of reasons (and also made writing these scenarios very
  difficult). To fix this we decided to switch to tasks with explicit
  behaviors.

  Scenario: Confirm configuration file replacement
    Given a file named "config.yml.dice" with:
      """
      config: <%= configured.value %>
      """
    And a file named "config.yml" with:
      """
      config: old value
      """
    When I run `rake VALUE='new value' config` interactively
    And I type "Y"
    Then the file "config.yml" should contain:
      """
      config: new value
      """

  Scenario: Deny configuration file replacement
    Given a file named "config.yml.dice" with:
      """
      config: <%= configured.value %>
      """
    And a file named "config.yml" with:
      """
      config: old value
      """
    When I run `rake VALUE='new value' config` interactively
    And I type "N"
    Then the file "config.yml" should contain:
      """
      config: old value
      """

  Scenario: Deny configuration file replacement with 'No' in addition to 'n'
    Given a file named "config.yml.dice" with:
      """
      config: <%= configured.value %>
      """
    And a file named "config.yml" with:
      """
      config: old value
      """
    When I run `rake VALUE='new value' config` interactively
    And I type "No"
    Then the file "config.yml" should contain:
      """
      config: old value
      """

  Scenario: Replace all configuration files
    Given a file named "config_1.yml.dice" with:
      """
      config: <%= configured.value %>
      """
    And a file named "config_2.yml.dice" with:
      """
      config: <%= configured.value %>
      """
    And a file named "config_1.yml" with:
      """
      config: old value
      """
    And a file named "config_2.yml" with:
      """
      config: old value
      """
    When I run `rake VALUE='new value' config` interactively
    And I type "A"
    Then the file "config_1.yml" should contain:
      """
      config: new value
      """
    Then the file "config_2.yml" should contain:
      """
      config: new value
      """

  Scenario: Automatically replace configuration files in a deployment context
    Given a file named "config.yml.dice" with:
      """
      config: <%= configured.value %>
      """
    And a file named "config.yml" with:
      """
      config: old value
      """
    When I run `rake VALUE='new value' config:deploy`
    Then the file "config.yml" should contain:
      """
      config: new value
      """
