require "sinatra/namespace"
require "net/http"
require "uri"
require "json"

set :session_secret, "asdkjadljakldsj"
enable :sessions

ROOT = ["", "/"]

def http_request(uri)
  Net::HTTP.start(uri.host, uri.port) do |http|
    yield(http, uri)
  end
end

###############################################
namespace "" do
  before do
    content_type "text/html"
  end
  get ROOT do
    erb :index
  end

  get "/create" do
    @mangas = Manga.all
    erb :create
  end
  
  get "/mangas" do
    url = "#{request.base_url}/api/mangas" # trailing slash is important
    uri = URI.parse(url)

    mangas = http_request(uri) do |http, uri|
      JSON.parse(http.get(uri.path).body)
    end
    p mangas
    erb :mangas, locals: {mangas: mangas}
  end

  get "/mangas/:title" do
    manga = Manga.where(title: params[:title]).first
    erb :manga_details, locals: { manga: manga }
  end

  get "/mangas/:title/chapters/:chapter_id" do
    url = "#{request.base_url}/api/chapters/#{params[:chapter_id]}" # trailing slash is important
    uri = URI.parse(url)

    chapter = http_request(uri) do |http, uri|
      JSON.parse(http.get(uri.path).body)
    end
    p chapter
    erb :chapter, locals: {chapter: chapter}
  end
end
###############################################

require_relative "mangas"
require_relative "chapters"
