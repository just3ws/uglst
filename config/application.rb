require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Uglst
  class Application < Rails::Application
    Dir.glob("#{config.root}/app/uglst/**/*.rb").each do |f|
      require f
    end

    config.autoload_paths << Rails.root.join('app', 'controllers', 'api', 'v1')

    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.encoding = 'utf-8'

    config.filter_parameters += %i(
      birthday
      ethnicity
      gender
      parental_status
      password
      password_confirmation
      race
      relationship_status
      religious_affiliation
      sexual_orientation
    )

    config.active_record.raise_in_transactional_callbacks = true

    config.time_zone = 'UTC'

    config.generators do |g|
      g.helpers = false
      g.javascripts = true
      g.stylesheets = true

      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

      g.view_specs false
      g.helper_specs false
      g.controller_specs false
    end

    console do
      config.console = Pry
    end

    config.after_initialize do
      Hirb.enable if ENV['ENABLE_HIRB'] && (Rails.env.development? || Rails.env.test?)
    end

    config.middleware.delete Rack::Lock
  end
end
