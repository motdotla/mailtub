module Rack
 
  # A Rack middleware for parsing POST/PUT body data when Content-Type is
  # not one of the standard supported types, like <tt>application/json</tt>.
  #
  # TODO: Find a better name.
  #
  class PostBodyContentTypeParser
 
    # Constants
    #
    CONTENT_TYPE = 'CONTENT_TYPE'.freeze
    POST_BODY = 'rack.input'.freeze
    FORM_INPUT = 'rack.request.form_input'.freeze
    FORM_HASH = 'rack.request.form_hash'.freeze
 
    # Supported Content-Types
    #
 
    ################## turned into regex so it matches type with encoding data...
    #APPLICATION_JSON = 'application/json'.freeze
    APPLICATION_JSON = /^application\/json/.freeze
 
    def initialize(app)
      @app = app
    end
 
    def call(env)
      case env[CONTENT_TYPE]
      when APPLICATION_JSON
        post_body       = env[POST_BODY]
        post_body_read  = post_body.read

        env.update(FORM_HASH => JSON.parse(post_body_read), FORM_INPUT => post_body) if post_body_read.length >= 2
      end
      @app.call(env)
    end
 
  end
end
