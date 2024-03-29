# :fire: :boom: :bomb: :boom: :fire: DEPRECATION NOTICE :fire: :boom: :bomb: :boom: :fire:

THIS GEM IS DEPRECATED!

# DiceBag

[![Build Status](https://travis-ci.com/mdsol/dice_bag.svg?branch=develop)](https://travis-ci.com/mdsol/dice_bag)
[![Code Climate](https://codeclimate.com/github/mdsol/dice_bag.png)](https://codeclimate.com/github/mdsol/dice_bag)

DiceBag is a library of rake tasks for configuring web apps in the style of [The
Twelve-Factor App][1]. Configuration values are picked up from the environment
and used to populate configuration files from templates. Pre-packaged templates
for common configuration files are provided.

Although Rails already supports ERB syntax for its YML configuration files, DiceBag will generate a final
static file that will work without keeping your deployment environment variables in sync with your
production environment variables. For security reasons, these environments may sometimes differ.

Also DiceBag will work with any kind of text files, not only YML files. It can be very useful for
ruby initializer files for instance.

[1]: http://www.12factor.net/

## Installation

Add the following to your `Gemfile`:

```ruby
gem 'dice_bag'
```

If you are using these tasks outside of a Rails project, add the following to
your `Rakefile` or wherever your local rake tasks are defined:

```ruby
require 'dice_bag/tasks'
```

Run the following command to see the new tasks:

```
[bundle exec] rake -T | grep "rake config"
```

## Create configuration files from templates

When the rake "config" task is run, configuration files are populated for all
ERB template files in the project that have a ".dice" extension. Configuration
values from the environment are made available to the templates through the
`configured` object.

For example, take a "database.yml.dice" file containing this template:

```erb
development:
  database: development
  username: <%= configured.database_username || 'root' %>
  password: <%= configured.database_password %>
```

Then running the following command:

```
DATABASE_USERNAME=alice DATABASE_PASSWORD=xyzzy [bundle exec] rake config
```

will generate a "database.yml" file with the following contents:

```yaml
development:
  database: development
  username: alice
  password: xyzzy
```

See the [feature documentation][features] for further examples and
functionality.

[features]: https://www.relishapp.com/mdsol/dice-bag/docs

As discussed in [The Twelve-Factor App section on configuration][2], do not
commit your generated configuration files to source control. Instead, commit the
templates to source control and then regenerate the configuration files at
deployment time by running the rake `config:deploy` task.

[2]: http://www.12factor.net/config


### Ensuring variables are set in production

It is a common pattern to use default information for development but to not
 allow defaults in production, instead we want to always set up the environment variables
in production.

It is very easy to discover what variables have not been set in production using a bang after
the variable name, for instance:
```
secret_key: <%= configured.secret_key_base! || 'any text is ok' %>
```
Will raise an explanatory error if we are using Rails, we are in production and the
 variable SECRET_KEY_BASE is not set. In other environments will not care about it
not being set and will use the default.


### Generating the templates of given gems only

`config:generate_all` will generate all the templates it can find. Since sometimes this behavior
is not desirable you can use the `config:generate_from_gems` task to specify gem names:

```
[bundle exec] rake config:generate_from_gems gem1 gem2 gemN
```

will generate only the templates provided by `gem1`, `gem2` and `gemN`.

To force-generate set the `DICEBAG_FORCE` environment variable to any value when running the task.


## Generating the pre-packaged templates

If the corresponding gems are installed, the following pre-packaged templates are provided:

* mysql2 or pg: `database.yml.dice` for [Rails](https://github.com/rails/rails/)
* aws-sdk: `aws.yml.dice`
* dalli: `dalli.yml.dice`

Run the following command to generate them:

```
[bundle exec] rake config:generate_all
```

This command provides options to compare changes between source and local templates, so new additions to the source templates can be safely added while preserving any project specific customization to local templates.

Alternatively, to force generate templates (replacing existing local templates with the source), run the following:

```
[bundle exec] rake config:generate_all:force
```


As with your own templates, you should commit these pre-packaged templates to
source control.

You can customize these pre-packaged template to your needs but if the change is
a generic fix or extension, please consider contributing it back to this project
so that everyone benefits.

### Defining your own pre-packaged templates

If you want DiceBag to generate your own pre-packaged templates when you run the
rake "config:generate_all" task, you can create a plug-in. Read the
[templates.md](./templates.md) file to learn how to do this.

## Troubleshooting

### rake config fails in Rails project with file not found

Due to rake running ``` config/application.rb ``` before kicking off a task,
if ``` config/application.rb ``` loads any configuration files that dice_bag
 must generate a 'file not found' error may occur.  Makes sense that a file
  ``` rake config:generate_all ``` needs to create, does not exist before it has ran.

Solution: Move any config loading that depends on files generated by dice_bag out of `application.rb` and into `config/initializers/*`.  Since the commands
`rails server` or `rails console` etc. always run the initializers, moving the logic
 here should be a safe bet.

## Contributors

* [Andrew Smith](https://github.com/asmith-mdsol)
* [Jordi Carres](https://github.com/jcarres-mdsol)
* [Dan Hoizner](https://github.com/dhoizner-mdsol)
* [Aaron Weiner](https://github.com/HonoreDB)
* [Luke Greene](https://github.com/lgreene-mdsol)
* [Johnny Lo](https://github.com/jlo188)
* [Connor Ross](https://github.com/cross311)
* [Mathieu Jobin](https://github.com/mjobin-mdsol)

