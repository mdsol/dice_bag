# frozen_string_literal: true

Given(/a Gemfile with dice_bag as a dependency/) do
  write_file("Gemfile", <<-EOF)
    source 'https://rubygems.org'

    gem 'dice_bag', path: '#{File.join(File.dirname(__FILE__), '../..')}'
  EOF
end
