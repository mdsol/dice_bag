# frozen_string_literal: true

require_relative "lib/dice_bag/version"

Gem::Specification.new do |s|
  s.name = "dice_bag"
  s.version = DiceBag::VERSION
  s.platform = Gem::Platform::RUBY
  s.license = "MIT"
  s.authors = ["Andrew Smith", "Jordi Carres"]
  s.email = ["asmith@mdsol.com", "jcarres@mdsol.com"]
  s.summary = "Dice Bag is a library of rake tasks for configuring web apps in the style of The Twelve-Factor App. " \
    "It also provides continuous integration tasks that rely on the configuration tasks."
  s.metadata = {
    "homepage_uri" => "https://github.com/mdsol/dice_bag",
    "changelog_uri" => "https://github.com/mdsol/dice_bag/blob/develop/CHANGELOG.md"
  }

  s.files = Dir["lib/**/*", "CHANGELOG.md", "MIT-LICENSE", "README.md"]
  s.test_files = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 2.3"

  s.add_dependency "diff-lcs", "~> 1.0"
  s.add_dependency "rake"
  s.add_dependency "thor", "< 2.0"

  s.add_development_dependency "aruba", "~> 0.6.0"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rubocop", "~> 1.8"
end
