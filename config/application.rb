require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Rails::Application::Config
  class Settings < Settingslogic
    source File.expand_path('../application.yml', __FILE__)
    namespace Rails.env
    load!
  end
end

module AutoTracker
  class Application < Rails::Application

    config.settings = Rails::Application::Config::Settings

    # Use sql instead of ruby to support case insensitive indices for postgres
    config.active_record.schema_format = :sql

    # Cache
    config.cache_store = :dalli_store, (ENV["MEMCACHIER_SERVERS"] || "").split(","),
        {:username => ENV["MEMCACHIER_USERNAME"],
         :password => ENV["MEMCACHIER_PASSWORD"],
         :failover => true,
         :socket_timeout => 1.5,
         :socket_failure_delay => 0.2
        }

    config.active_record.raise_in_transactional_callbacks = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # Disable I18n locale deprecation warning caused by newrelic gem
    # http://stackoverflow.com/questions/20361428/rails-i18n-validation-deprecation-warning
    I18n.enforce_available_locales = true

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.time_zone = 'Eastern Time (US & Canada)'

    # Enable faster precompiles
    config.assets.initialize_on_precompile = false
    config.active_job.queue_adapter = :sidekiq
    config.action_mailer.asset_host = Rails.application.config.settings.action_mailer.asset_host

    # Serve vendor fonts
    config.assets.paths << Rails.root.join('vendor', 'assets', 'icheck')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'javascripts')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'stylesheets')

    config.assets.precompile += %w( pdf_layout.css head.js ie.js emails/inline.css emails/include.css sidebar.css.scss vehicle_report_cards.scss bootstrap-toggle.min.css bootstrap-toggle.min.js )

    config.to_prepare do
      Devise::Mailer.layout Rails.application.config.settings.mail.layout
    end

    # config.middleware.use "PDFKit::Middleware", :print_media_type => true
    config.middleware.use WickedPdf::Middleware, :print_media_type => true
  end
end

require File.expand_path('../settings', __FILE__)
