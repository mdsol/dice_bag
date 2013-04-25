Feature: Add warnings to configuration files

  We don't really want developers to directly edit the output configuration
  files, they should re-run the `rake config` task. To that end, we want to
  output a warning into the output file but having that warning text verbatim in
  the template file will be confusing. So, we provide helpers like
  `warning.as_yaml_comment` for use in the templates.

  Scenario: Add a warning in a YAML file
    Given a file named "database.yml.dice" with:
      """
      <%= warning.as_yaml_comment %>
      """
    When I run `rake config`
    Then the file "database.yml" should contain:
      """
      # WARNING! Do not modify this file directly. It was generated from the
      # 'database.yml.dice' template file.
      # 
      # Use the rake config task to reconfigure. See the template file for
      # further guidance.
      """

  Scenario: Add a warning in a Ruby file
    Given a file named "secret_token.rb.dice" with:
      """
      <%= warning.as_ruby_comment %>
      """
    When I run `rake config`
    Then the file "secret_token.rb" should contain:
      """
      # WARNING! Do not modify this file directly. It was generated from the
      # 'secret_token.rb.dice' template file.
      # 
      # Use the rake config task to reconfigure. See the template file for
      # further guidance.
      """

  Scenario: Add a warning in a XML file
    Given a file named "web.config.dice" with:
      """
      <%= warning.as_xml_comment %>
      """
    When I run `rake config`
    Then the file "web.config" should contain:
      """
      <!--
      WARNING! Do not modify this file directly. It was generated from the
      'web.config.dice' template file.
      
      Use the rake config task to reconfigure. See the template file for
      further guidance.
      -->
      """

