require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SeCase
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.hosts << 'se.webng.md'

    config.generators do |g|
      # g.test_framework :rspec, fixture: true, views: false
      # g.integration_tool :rspec, fixture: true, views: false
      # g.javascript_engine :coffee
      # g.orm :active_record
      # g.stylesheet_engine :scss
      g.template_engine :slim
      g.helper = false
      g.stylesheets = false
      g.javascripts = false
    end
  end
end
