require 'simplecov'
SimpleCov.command_name('Minitest')
SimpleCov.start('rails')

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

Capybara.server = :puma, { Silent: true }

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  parallelize(workers: :number_of_processors)

  parallelize_setup do |worker|
    SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
  end

  parallelize_teardown do |worker|
    SimpleCov.result
  end

  # fixtures :all
end
