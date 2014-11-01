class ApplicationController < Sinatra::Base
  helpers Sinatra::AuthenticationHelper
  helpers Sinatra::LinkHelper

  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  enable :sessions, :method_override


get '/' do
  erb :root
end

get '/welcome' do
  authenticate!
  erb :index
end

get '/login' do
  erb :login
end

end