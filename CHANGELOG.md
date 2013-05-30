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

