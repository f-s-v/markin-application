ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'pry'
require 'rails/test_help'
require 'capybara/rails'
require 'support/capybara_helper'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    js_errors: false,
    window_size: [1024, 2048]
  )
end

Capybara.default_driver = Capybara.javascript_driver = :poltergeist

# Capybara.javascript_driver = :webkit
# Capybara.default_driver = :webkit
Capybara.server_port = 5000

# >> https://github.com/jnicklas/capybara#transactions-and-database-setup
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
# <<

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  self.use_transactional_fixtures = true

  # Add more helper methods to be used by all tests here...

end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  include Rails.application.routes.url_helpers
end