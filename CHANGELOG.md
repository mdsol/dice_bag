# 1.1.0

* Removed the template for Newrelic.

# 1.0.0

* `config:generate_all` task allows user to choose an appropriate action when source and local templates are different. 
* `config:generate_all:force` allows user to generate templates in 'force mode' (replacing local templates with the source).

# 0.9.0

* Feature: Adding a bang (!) at the end of method names, will raise when the variable
 is not found in production.
* New relic template to use SSL by default

# 0.8.0

* Fix Template generation fails if the target directory is missing
* Document that configuration files must not be loaded in Rails config/application.rb
* Don't overwrite config files if user responds 'No' instead of just 'N'.
* Omit .dice files in Bundler path or in dot-prefixed directories

# 0.7.1

* The ensure_is_private_key method now additionally supports RSA keys without spaces.

# 0.7.0

* New ensure_is_private_key helper method to process RSA private keys.
* New config:deploy rake task to use for deployments, which overwrites config files without prompting.

# 0.6.0

* **Breaking change:** Only templates with the '.dice' extension are processed.
* **Breaking change:** Local override via the '.local' extension has been removed.
* Templates are processed in all directories.

# 0.5.0

* Generated templates should be committed to source control.
* New '.dice' extension for templates.
* Better testing infrastructure.
* Plugins and rake task can specify custom location for templates.

# 0.4.1

* Fix: Templates are generated in 'config' directory for Rails projects.

# 0.4.0

* Initial open source release.

