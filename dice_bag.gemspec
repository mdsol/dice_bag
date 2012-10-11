require File.expand_path('../lib/dice_bag/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'dice_bag'
  s.version = DiceBag::VERSION
  s.platform = Gem::Platform::RUBY

  s.authors = ['Andrew Smith']
  s.email = ['asmith@mdsol.com']
  s.summary = 'Dice Bag is a library of rake tasks for configuring web apps in the style of The Twelve-Factor App. It also provides continuous integration tasks that rely on the configuration tasks.'

  s.files = Dir['lib/**/*']
  s.test_files = Dir['spec/**/*']
  s.executables = Dir['bin/*'].map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
