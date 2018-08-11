require 'sinatra'
#require 'sinatra/reloader'

set :session_secret, 'asdkjadljakldsj'
enable :sessions

get '/' do
  erb :index
end


get '/hi' do
  print session
  @name = session.delete(:user)
  erb :hi
end

post '/hi' do
  @name = params['name']
  session[:user] = @name
  print session
  redirect '/hi'
end
