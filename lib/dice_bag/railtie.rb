# frozen_string_literal: true

module DiceBag
  class Railtie < Rails::Railtie
    rake_tasks do
      require "dice_bag/tasks"
    end
  end
end
