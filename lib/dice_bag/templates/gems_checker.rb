# frozen_string_literal: true

# This module has the logic that decides what templates will be
# generated for this project.
# this file lives in the same directory than all the templates it
# provides logic for.
require "dice_bag"

module DiceBag
  class CommonTemplatesBag < AvailableTemplates
    def templates
      @needed_templates = []
      configured = Configuration.new

      add_template("dalli.yml.dice") if defined?(Dalli)

      if defined?(Mysql2)
        add_template("databases/mysql.yml.dice", save_as: "database.yml.dice")
      elsif defined?(PG)
        add_template("databases/postgres.yml.dice", save_as: "database.yml.dice")
      end

      add_template("aws.yml.dice") if defined?(AWS)

      add_template("google_analytics.yml.dice") if configured.google_analytics_id

      @needed_templates
    end

    def add_template(file, save_as: nil)
      pwd = File.dirname(__FILE__)
      @needed_templates.push([File.join(pwd, file), save_as])
    end
  end
end
