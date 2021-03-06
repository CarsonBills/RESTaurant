require 'bundler'
Bundler.require(:default)

Dir.glob('./helpers/*.rb').
each do |file|
  require file
  puts "require #{file}"
end

require './controllers/application_controller'

Dir.glob('./{models,controllers}/*.rb').
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