require File.expand_path("../lib/dice_bag/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "dice_bag"
  s.version = DiceBag::VERSION
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.8.7"

  s.license = 'MIT'

  s.authors = ["Andrew Smith", "Jordi Carres"]
  s.email = ["asmith@mdsol.com", "jcarres@mdsol.com"]
  s.summary = "Dice Bag is a library of rake tasks for configuring web apps in the style of The Twelve-Factor App. It also provides continuous integration tasks that rely on the configuration tasks."
  s.homepage = "https://github.com/mdsol/dice_bag"

  s.files = Dir["lib/**/*"]
  s.test_files = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency "rake"
  s.add_dependency "thor", "~> 0.0"
  s.add_dependency "diff-lcs", "~> 1.0"
  s.add_development_dependency "aruba", "~> 0.5.1"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "bundler"
end
