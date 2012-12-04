# Dice Bag

Dice Bag is a library of rake tasks for configuring web apps in the style of
[The Twelve-Factor App][1].

[1]: http://www.12factor.net/

## Install

Add the following to your `Gemfile`:

```ruby
gem 'dice_bag', :git => 'git@github.com:mdsol/dice_bag.git'
```

If you are using these tasks outside of a Rails project, add the following to
your `Rakefile` or wherever your local rake tasks are defined:

```ruby
require 'dice_bag/tasks'
```

Run the following command to see the new tasks:

```
[bundle exec] rake -D config
```

## Rationale

This gem provides two main tasks: config:all and config:generate_all.
config:all will generate configuration files from the templates you have
in your config/ directory. 
config:generate_all will create predefined templates in your config/
directory. 
In addition 'rake:config' will call these two tasks in one command.

We recommend you to add to your .gitignore the generated configuration files
but to commit to your repository your template files. Doing this, you can
keep the history of the changes in your configuration. 
If you need to have keys in your configuration files, they should be set up in
environmental variables which are read by the configuration object in
the templates.

We try hard to create template files which are intelligent and general 
enough to cover all the cases, they can also be set up using environment
variables. If any template does not fulfill your needs, 
please open an issue on this gem Github page and we will address it. 

Also, as a last resort, you can have your own per-project templates.
These local templates are suffixed with .local. For instance if you have
a config/database.yml.erb.local file, this file will be used instead of
config/database.yml.erb to generate config/database.yml. Your local
templates are never overwrited but they also can never be updated. We
strongly recommend using the generated templates instead.


## Define your own templates

In the case you want Dice bag to generate your own templates when you
call config:generate all you can create a plugin for dice-bag. Read the
[templates] file to know how to do this.

## Owners

* [Andrew Smith](mailto:asmith@mdsol.com)
* [Jordi Polo](mailto:jcarres@mdsol.com)
