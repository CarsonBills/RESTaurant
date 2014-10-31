require 'bundler'
Bundler.require

require 'pry'

# MODELS

require_relative 'models/food'
require_relative 'models/party'
require_relative 'models/order'
require_relative 'models/user'

# HELPERS
require_relative 'helpers/link_helper'
helpers ActiveSupport::Inflector

# DATABASE

ActiveRecord::Base.establish_connection({
	adapter: 'postgresql',
	database: 'restaurant'
	})

enable :sessions

get '/' do
	erb :root
end

get '/welcome' do
	erb :index
end

get '/login' do
	erb :login
end

post '/sessions' do
	user = User.find_by({username: params[:username]})
	if user && user.password == params[:password]
		session[:current_user] = user.id
		redirect '/welcome'
	else
		redirect '/sessions/login'
	end
end

delete '/sessions' do
	session[:current_user] = nil
	redirect '/'
end

get 'users/new' do
	erb :'users/new'
end

post '/users' do
	user = User.new(params[:user])
	user.password = params[:password]
	user.save!
	redirect '/welcome'
end

get '/foods' do
	@foods = Food.all
	erb :'foods/index'
end

get '/foods/new' do
	erb :'foods/new'
end

post '/foods' do
	food = Food.create(params[:food])
	if food.valid?
		redirect '/foods'
	else
		@errors = food.errors.full_messages
		erb :'foods/new'
	end
end

get '/foods/:id' do
	@food = Food.find(params[:id])
	#@parties = Party.find(params[:order][:id])
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


# PARTIES ROUTES

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
	@paid = @party.paid
	erb :"parties/show"
end

get '/parties/:id/edit' do
	@party = Party.find(params[:id])
	@paid = @party.paid
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
	@party = Party.find(params[:party][:id])
	begin
		@party.add_food(food)
		redirect "/parties/#{@party.id}"
	rescue Party::TicketClosedError => e
		@error = e.message
		erb :'parties/error'
	end
end

delete '/orders/:id' do
	Order.delete(params[:id])
	redirect "/parties/#{params[:party][:id]}"
end

post '/parties/:id' do
	@party = Party.find(params[:id])
	@party.print_receipt
	redirect "/parties/#{@party.id}/receipt"
end

get '/parties/:id/receipt' do
	party = Party.find(params[:id])
	receipt = party.foods
	prices = receipt.map {|item| item[:price]}
	@total = prices.inject(:+)
	@receipt_items = File.read('public/receipts/receipt.txt').split("\n")
	erb :"parties/receipt"
end

patch '/parties/:id/checkout' do
	party = Party.find(params[:id])
	party.update(params[:party])
	redirect "/parties/#{params[:party][:id]}"
end
