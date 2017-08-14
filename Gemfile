source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.5.2'
gem 'json', '1.8.3' #added this because below versions has issues with ruby 2.3.0
gem 'responders', '~> 2.0'

group :darwin do
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
end

group :linux do
  gem 'rb-inotify', require: false
  gem 'libnotify', require: false
end

gem 'pg'

gem 'dalli'
gem 'kgio'
gem 'aasm'

gem 'sass-rails'
gem 'haml-rails'
gem 'simple_form'
gem 'uglifier'
gem 'headjs-rails'
gem "bower-rails", "~> 0.10.0"
gem 'data-confirm-modal'

# Javascript
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'nprogress-rails'

gem 'coffee-rails'
gem 'bootstrap-sass'
gem 'momentjs-rails', '~> 2.9',  :github => 'derekprior/momentjs-rails'
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true


gem 'devise'
gem 'cancancan', '~> 1.9'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

gem 'rails_admin'

gem 'sidekiq'
gem 'redis-namespace'
gem 'devise-async'
gem 'sinatra', require: false

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

gem "paranoia", "~> 2.0"

gem 'addressable'
gem 'settingslogic'
gem 'devise_invitable', '~> 1.5.2'
gem 'bh'
gem "breadcrumbs_on_rails"

gem 'rack-rewrite', '~> 1.5.0'

group :development do
  gem 'sdoc', require: false    # bundle exec rake doc:rails
  gem 'guard-rspec'
end

group :development, :test do
  gem 'spring'                  # keep application running in the background
  gem 'spring-commands-rspec'
  gem 'pry-rails'               # adds rails specific commands to pry
  gem 'pry-byebug'              # add debugging commands to pry
  gem 'pry-stack_explorer'      # navigate call stack
  gem 'awesome_print'           # pretty pring debugging output
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'quiet_assets'
end

group :test do
  gem 'minitest'                # include minitest to prevent require 'minitest/autorun' warnings
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'simplecov', require: false
  gem 'rspec-sidekiq'
  gem 'rspec-activemodel-mocks'
end

group :production, :qa, :test, :staging do
  gem 'unicorn'
  gem 'rails_12factor'          # https://devcenter.heroku.com/articles/rails4
  gem 'rack-timeout', '~> 0.1.0beta4'
  gem 'newrelic_rpm'
  gem 'airbrake', '~> 5.1'
end
