source "https://rubygems.org"
ruby '1.9.3'

gem 'activerecord', '~> 3.2.8'
gem 'dotenv'
gem 'foreman'
gem 'json', '~> 1.7.7'
gem 'jsonify', '0.4.0',         require: %w(jsonify jsonify/tilt)
gem 'pg'
gem 'pry'
gem 'racksh'
gem 'rake'
gem 'redis'
gem 'therubyracer',             require: 'v8'
gem 'rack-cors',                require: 'rack/cors'
gem 'rack-rewrite', '1.3.3',    require: 'rack/rewrite'
gem 'sinatra', '1.3.4',         require: 'sinatra/base'
gem 'sinatra-activerecord',     require: 'sinatra/activerecord'
gem 'sinatra-contrib',          require: %w(sinatra/multi_route sinatra/reloader sinatra/streaming sinatra/content_for)
gem 'unicorn'

group :development, :test do
  gem 'database_cleaner'
  gem 'rb-fsevent'
end

group :test do
  gem 'factory_girl'
  gem 'rack-test',              require: 'rack/test'
  gem 'rspec'
  gem 'webmock', '1.6.2',       require: false
end
