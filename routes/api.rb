require 'sinatra/namespace'

set :session_secret, 'asdkjadljakldsj'
enable :sessions

ROOT = ['', '/']

###############################################
namespace '' do
  before do
    content_type 'text/html'
  end
  get ROOT do
    erb :index
  end

  get '/create' do
    @mangas = Manga.all
    erb :create
  end
end
###############################################

require_relative 'mangas'
require_relative 'chapters'
