require 'sinatra/namespace'
require './helpers/api_helpers'

set :session_secret, 'asdkjadljakldsj'
enable :sessions

###############################################
get '/' do
  erb :index
end

get '/create' do
  @mangas = Manga.all
  erb :create
end
###############################################

require_relative 'mangas'
require_relative 'chapters'
