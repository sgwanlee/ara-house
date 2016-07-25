
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class CarrierWave::Mount::Mounter
  def store!
    # Not storing uploads in the tests
  end
end


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  CarrierWave.root = Rails.root.join('public/images')

  def after_teardown
    super
    CarrierWave.clean_cached_files!(0)
  end

  include ApplicationHelper

  # Add more helper methods to be used by all tests here...

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  #Logs in a test user.
  def log_in_as(user, options={})
  	password = options[:password]	|| 'password'
  	remember_me = options[:remember_me] || '1'
  	if integration_test?
  		post login_path, session:  { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
    	session[:user_id] = user.id
    end
  end
  
  private
  	#Returns true inside an integration test
  	def integration_test?
  		defined?(post_via_redirect)
  	end
end
