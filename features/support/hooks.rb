Before do
  write_file("Rakefile", "require 'dice_bag/tasks'")
end

Around '@original-bundler-environment' do |_, block|
  if defined?(Bundler)
    Bundler.with_original_env do
      block.call
    end
  else
    block.call
  end
end