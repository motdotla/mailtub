require 'open-uri'
class Application < Sinatra::Base
  disable :protection # disabling rack/protection which is by default enabled with Sinatra

  use Rack::WWWAndSSL if RACK_ENV == "production"

  use Rack::Cors do |config|
    config.allow do |allow|
      allow.origins '*'
      allow.resource '/*', headers: :any, methods: [:get, :post, :put, :delete, :options]
    end
  end

  register Sinatra::ActiveRecordExtension
  register Sinatra::MultiRoute
  helpers Sinatra::Streaming
  helpers Sinatra::ContentFor

  disable :show_exceptions
  disable :raise_errors

  configure do
    set :database, DATABASE_URL
    ActiveRecord::Base.logger = nil unless RACK_ENV == "development"
  end

  helpers do
    def jsonify(*args)
      render(:jsonify, *args)
    end
  end

  not_found do
    @message = "API endpoint not found."
    jsonify :"error"
  end

  get "/sync.json" do
    RawEmail.sync!
    jsonify :"sync"
  end

  get "/raw_emails/index.json" do
    @raw_emails = RawEmail.all
    jsonify :"/raw_emails/index"
  end
end
