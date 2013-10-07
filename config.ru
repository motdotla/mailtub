require File.dirname(__FILE__) + '/config/boot.rb'

use Rack::Static, :urls => ['/images', '/javascripts', '/pdfs', '/favicon.ico', '/assets'], :root => 'public'

run Rack::URLMap.new({
  "/" => Application
})
