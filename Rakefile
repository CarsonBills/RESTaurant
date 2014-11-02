require 'bundler'
Bundler.require
require 'sinatra/activerecord/rake'

require_relative 'models/food'
require_relative 'models/party'
require_relative 'models/order'
require_relative 'connection'



namespace :db do
	desc "Create restaurant database"
	task :create_db do
		conn = PG::Connection.open()
		conn.exec('Create DATABASE restaurant;')
		conn.close
	end

	desc "Drop restaurant database"
	task :drop_db do
		conn = PG::Connection.open()
		conn.exec('DROP DATABASE restaurant;')
		conn.close
	end

	desc "Create Junk Data"
	task :junk_data do

		Food.create({name: "Steak", price: 20})
		Food.create({name: "Bread", price: 2})
		Food.create({name: "Salad", price: 11})
		Food.create({name: "Beer", price: 8})
		Food.create({name: "Wine", price: 10})

		Party.create({name: "Smith", size: 2})
		Party.create({name: "Lanchester", size: 3})
		Party.create({name: "Fiddler", size: 5})
		Party.create({name: "Alexanderson", size: 2})
		Party.create({name: "Calhoun", size: 4})
		Party.create({name: "Lee", size: 4})

		parties = Party.all
		foods = Food.all

		100.times do
			Order.create({food_id: foods.sample.id, party_id: parties.sample.id})
		end
	end
end