class UsersController < ApplicationController

  get '/new' do
    erb :'users/new'
  end

  post '/' do
    user = User.new(params[:user])
    user.username = params[:username]
    user.password = params[:password]
    user.save!
    redirect '/sessions/new'
  end

end