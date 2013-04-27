Feature: Providing values per environment

  In applications frameworks like Rails it's usual to have configuration against
  multiple "environments". DiceBag allows you to use a prefixed environment
  variable to override an existing environment variable, meaning you could
  specify different values per application environment as well as defaults. The
  prefixed value is accessed through the `[]` operator on `configured`.

  Scenario: Using the `[]` operator to access prefixed override values
    Given a file named "database.yml.dice" with:
      """
      <% [:development, :test, :production].each do |env| %>
      <%= env %>:
        database: <%= env %>
        username: <%= configured[env].username %>
        password: <%= configured[env].password %>
      <% end %>
      """
    When I run `rake USERNAME=alice PASSWORD=xyzzy PRODUCTION_PASSWORD=zxcvb config`
    Then the file "database.yml" should contain:
      """
      development:
        database: development
        username: alice
        password: xyzzy
      test:
        database: test
        username: alice
        password: xyzzy
      production:
        database: production
        username: alice
        password: zxcvb
      """

