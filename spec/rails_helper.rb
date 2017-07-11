require 'spec_helper'
require 'capybara/rspec'
require 'devise'
require_relative 'support/controller_macros'
require_relative 'support/login_helpers'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Mongoid::Matchers, type: :model
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.extend ControllerMacros, type: :controller
  config.include Warden::Test::Helpers, type: :request
  config.include LoginHelpers, type: :request
  config.include LoginHelpers, type: :feature
  config.include Devise::TestHelpers, type: :controller
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    # with.test_framework :minitest
    # with.test_framework :minitest_4
    # with.test_framework :test_unit
    # with.library :active_record
    # with.library :active_model
    # with.library :action_controller
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end
