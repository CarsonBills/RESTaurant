require 'bundler'
Bundler.require(:default)

require './controllers/application_controller'
require './controllers/foods_controller'
require './controllers/orders_controller'
require './controllers/parties_controller'
require './controllers/sessions_controller'
require './controllers/users_controller'

Dir.glob('./{helpers,models,controllers}/*.rb').
each do |file|
	require file
	puts "require #{file}"
end

map('/sessions'){run SessionsController }
map('/users'){run UsersController }
map('/'){ run ApplicationController }
map('/parties'){ run PartiesController }
map('/foods'){ run FoodsController }
map('/orders'){ run OrdersController }