# frozen_string_literal: true

require_relative "dice_bag/available_templates"
module DiceBag
  require "dice_bag/railtie" if defined?(Rails)
end
