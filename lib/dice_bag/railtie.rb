module DiceBag
  class Railtie < Rails::Railtie
    railtie_name :dice_bag

    rake_tasks do
      require 'dice_bag/tasks'
    end
  end
end
