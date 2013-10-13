ENV["RACK_ENV"] ||= "development"

require 'bundler'
Bundler.setup

require 'active_support' # http://stackoverflow.com/questions/14824179/typeerror-cannot-visit-mailmultibytechars
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require 'dotenv'
Dotenv.load ".env.#{Sinatra::Base.environment.to_s}", '.env'

require './config/constants'
require './config/post_body_content_type_parser'
require './config/redis'

Dir["./lib/**/*.rb"].each { |f| require f }

require './app/application'

Dir["./app/*.rb"].each { |f| require f }
Dir["./app/models/*.rb"].each { |f| require f }
Dir["./app/workers/*.rb"].each { |f| require f }
