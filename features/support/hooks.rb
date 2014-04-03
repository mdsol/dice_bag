Before do
  write_file("Rakefile", "require 'dice_bag/tasks'")
end

Around '@clean-bundler-environment' do |_, block|
  if defined?(Bundler)
    Bundler.with_clean_env do
      block.call
    end
  else
    block.call
  end
end