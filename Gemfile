source "https://rubygems.org"

gem "rails", "6.0.3.5"

gem "activerecord-import"
gem "activerecord-session_store", github: "rails-lts/activerecord-session_store", branch: "secure-session-store"
gem "acts-as-taggable-on"
gem "apache_log-parser"
gem "aws-sdk-s3"
gem "bootstrap-sass"
gem "gds-api-adapters"
gem "google-api-client"
gem "govuk_admin_template"
gem "govuk_app_config"
gem "gretel"
gem "htmlentities"
gem "kaminari"
gem "mlanett-redis-lock"
gem "optic14n" # Ideally version should be synced with bouncer
gem "paper_trail"
gem "pg"
gem "plek"
gem "puma"
gem "rails_warden"
gem "redis-namespace"
gem "rollbar"
gem "ruby-ip"
gem "select2-rails", "3.5.7"
gem "sidekiq"
gem "sidekiq-cron"
gem "whenever"

# Custom authentication...
gem "omniauth", "1.9.1"
gem "omniauth-auth0", "~> 2.2"
gem "omniauth-rails_csrf_protection", "~> 0.1"

gem "sass"
gem "sass-rails"
gem "sprockets", "< 4.0"
gem "uglifier"

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "cucumber-rails", require: false
  gem "cuprite"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "launchy" # Primarily for save_and_open_page support in Capybara
  gem "rails-controller-testing"
  gem "rspec-sidekiq"
  gem "shoulda-matchers"
  gem "simplecov"
  gem "timecop"
  gem "webdrivers"
  gem "webmock", require: false
end

group :development, :test do
  gem "dotenv-rails"
  gem "govuk-lint"
  gem "govuk_test"
  gem "jasmine"
  gem "jasmine_selenium_runner"
  gem "pry"
  gem "rspec-collection_matchers"
  gem "rspec-rails"
  gem "rubocop-govuk"
end
