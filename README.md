# Dice Bag

Dice Bag is a library of rake tasks for configuring web apps in the style of
[The Twelve-Factor App][1]. It also provides continuous integration tasks that
rely on the configuration tasks.

[1]: http://www.12factor.net/

## Usage

Add the following to your `Gemfile`:

```ruby
gem 'dice_bag', :git => 'git@github.com:mdsol/dice_bag.git'
```

The current `ci` tasks assume you are using the shamus and brakeman tools, so
add the following to your `Gemfile` if you intend to use these tasks:

```ruby
group :development, :test do
  gem 'shamus', :git => 'git@github.com:mdsol/shamus.git', :tag => '0.9.4'
  gem 'brakeman', '~> 1.8'
end
```

You should specify versions appropriate for your project! No need to deploy
these in production, so we scope them to the appropriate groups.

If you are using these tasks outside of a Rails project, add the following to
your `Rakefile` or wherever your local rake tasks are defined:

```ruby
require 'dice_bag/tasks'
```

Now run the following command to see the new tasks in the `config` and `ci`
namespaces:

```
[bundle exec] rake -T
```

## TODO

* Describe the template-and-environment-driven processing here.
* Make the `config:all` task process all ERB template files present.
* Make the `ci:run` task detect installed tools (but this is possibly a non-goal
  if we want to be opinionated about the CI tool-chain).
* Make `config:db` use `db/schema.rb` if present rather than migrate a clean
  database.
* Possibly move database migrations from `ci:config` to `config:db` (ask
  DevOps).
* Add `config:generate:rails:db` or similar to spew out standard templates.

## Owners

* Andrew Smith

