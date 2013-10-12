uri   = URI.parse(ENV["REDIS_URL"].to_s)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
