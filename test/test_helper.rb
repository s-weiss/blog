ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def auth_header(user = users(:alice))
    token = JWT.encode({user_id: user.id}, nil, 'none')
    @auth_header = {"AUTHORIZATION": "Bearer: #{token}"}
  end
end
