require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Uglst
  class Application < Rails::Application
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled                              = true
    config.assets.version                              = '1.0'
    config.encoding                                    = 'utf-8'
    config.filter_parameters                           += [
      :birthday,
      :ethnicity,
      :gender,
      :parental_status,
      :password,
      :password_confirmation,
      :race,
      :relationship_status,
      :religious_affiliation,
      :sexual_orientation
    ]

    config.time_zone = 'UTC'

    config.generators do |g|
      g.helper = false
      g.helper_specs false
      g.javascripts = false
      g.stylesheets = false
      g.test_framework :rspec, fixture: true
      g.view_specs false
    end

    console do
      config.console = Pry
    end

    config.after_initialize do
      Hirb.enable if Rails.env.development? || Rails.env.test?
    end

  end
end
