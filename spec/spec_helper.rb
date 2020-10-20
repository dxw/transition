RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding external_api: true
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.order = :random

  Kernel.srand config.seed
end

require "pry"
require "sidekiq/testing"
Dir[File.expand_path("../app/workers/**/*_worker.rb", File.dirname(__FILE__))].sort.each do |file|
  require file
end

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
require "rspec/rails"
