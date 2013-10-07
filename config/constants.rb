RACK_ENV                  = ENV['RACK_ENV']
DATABASE_URL              = ENV['DATABASE_URL']

case RACK_ENV
when "production"
when "staging"
when "test"
  QUEUE_INLINE            = true
else  
  # defined above 
end
