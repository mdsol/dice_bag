# Dice Bag

Dice Bag is a library of rake tasks for configuring web apps in the style of
[The Twelve-Factor App][1].

[1]: http://www.12factor.net/

## Usage

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

## TODO

* Describe the template-and-environment-driven processing here.
* Add `config:generate:rails:db` or similar to spew out standard templates.

## Owners

* [Andrew Smith](mailto:asmith@mdsol.com)
* [Jordi Polo](mailto:jcarres@mdsol.com)

