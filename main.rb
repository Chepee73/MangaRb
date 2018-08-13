require 'sinatra'
require 'sinatra/reloader'

require './database'
require './models/manga'
require './models/chapter'

set :session_secret, 'asdkjadljakldsj'
enable :sessions

require './api'