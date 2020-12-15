# frozen_string_literal: true

Given(/^I am running Rails in production$/) do
end
class RailsEnv
  def production?
    true
  end
end

class Rails
  def self.env
    RailsEnv.new
  end
end
