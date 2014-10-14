require 'bundler'
Bundler.require

require_relative 'models/food'
require_relative 'models/party'

ActiveRecord::Base.establish_connection({
	adapter: 'postgresql',
	database: 'restaurant'
	})

get '/' do
	erb :index
end

get '/foods' do
	@foods = Food.all
	erb :'foods/index'
end

get '/foods/new' do
	erb :'foods/new'
end

post '/foods' do
	Food.create(params[:food])
	redirect '/foods'
end