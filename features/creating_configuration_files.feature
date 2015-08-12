Feature: Creating configuration files

  Run the rake task `config` to create configuration files. These are created
  by populating configuration values from the environment into template
  configuration files.

  Templates are identified by a final `.dice` extension in their filename. They
  can be anywhere in the current working directory or below it. The `.dice`
  extension is stripped off to create the final configuration filename, which
  is created beside the template in the same directory.

  Templates are processed as ERB source files. Configuration values from the
  environment are made available through the `configured` object. If a
  referenced environment variable is undefined `nil` is returned, allowing you
  to provide defaults directly in the template.

  Scenario: Populating a YAML configuration file from an ERB template
    Given a file named "database.yml.dice" with:
      """
      development:
        database: development
        username: <%= configured.database_username %>
        password: <%= configured.database_password %>
      """
    When I run `rake DATABASE_USERNAME=alice DATABASE_PASSWORD=xyzzy config`
    Then the file "database.yml" should contain:
      """
      development:
        database: development
        username: alice
        password: xyzzy
      """

  Scenario: Providing default configuration values
    Given a file named "database.yml.dice" with:
      """
      development:
        database: development
        username: <%= configured.database_username || 'root' %>
        password: <%= configured.database_password %>
      """
    When I run `rake config`
    Then the file "database.yml" should contain:
      """
      development:
        database: development
        username: root
        password: 
      """

  Scenario Outline: Recursive descent of directories
    Given an empty file named "<file>.dice"
    When I run `rake config`
    Then a file named "<file>" should exist

    Examples:
      | file                                |
      | config.ru                           |
      | config/database.yml                 |
      | config/initializers/secret_token.rb |

  Scenario: Accepting bang(!) methods in a development environment
    Given a file named "database.yml.dice" with:
      """
      development:
        database: development
        username: <%= configured.database_username! %>
        password: <%= configured.database_password! %>
      """
    When I run `rake DATABASE_USERNAME=roger DATABASE_PASSWORD=ackroyd config`
    Then the file "database.yml" should contain:
      """
      development:
        database: development
        username: roger
        password: ackroyd
      """
