require './application'

use Rack::Reloader, 0
run Application.new
