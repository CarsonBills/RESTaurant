require 'bundler'
Bundler.require

require_relative 'models/food'
require_relative 'models/party'
require_relative 'models/order'

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

get '/foods/:id' do
	@food = Food.find(params[:id])
	erb :'foods/show'
end

get '/foods/:id/edit' do
	@food = Food.find(params[:id])
	erb :'foods/edit'
end

patch '/foods/:id' do
	food = Food.find(params[:id])
	food.update(params[:food])
	redirect "/foods/#{food.id}"
end

delete '/foods/:id' do
	Food.delete(params[:id])
	redirect "/foods"
end




get '/parties' do
	@parties = Party.all
	erb :'parties/index'
end

get '/parties/new' do
	erb :'parties/new'
end

post '/parties' do
	Party.create(params[:party])
	redirect '/parties'
end

get '/parties/:id' do
	@party = Party.find(params[:id])
	@foods = Food.all
	erb :"parties/show"
end

get '/parties/:id/edit' do
	@party = Party.find(params[:id])
	erb :"parties/edit"
end

patch '/parties/:id' do
	party = Party.find(params[:id])
	party.update(params[:party])
	redirect "/parties/#{party.id}"
end

delete '/parties/:id' do
	Party.delete(params[:id])
	redirect "/parties"
end

post '/orders' do
	food = Food.find(params[:food][:id])
	party = Party.find(params[:party][:id])
	party.foods << food
	@party = Party.find(params[:party][:id])
	redirect "/parties/#{party.id}"
end

patch 'orders/:id' do
	binding.pry
	@price = Food.find(params[:food][:price])
	redirect "/parties/#{party.id}"
end
