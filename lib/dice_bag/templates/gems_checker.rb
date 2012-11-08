module DiceBag
  def self.needed_templates
    needed_templates = []
    configured = Configuration.new

    if defined?(Dalli)
      needed_templates.push('dalli.yml.erb')
    end

    if defined?(Mysql2)
      needed_templates.push('database.yml.erb')
    end

    if defined?(AWS)
      needed_templates.push('aws.yml.erb')
    end

    if configured.google_analytics_id
      needed_templates.push('google_analytics.yml.erb')
    end

    needed_templates
  end
end
