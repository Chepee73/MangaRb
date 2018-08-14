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


namespace '/api/v1' do
  before do
    content_type 'application/json'
  end
  namespace '/mangas' do
    get '' do
      mangas = Manga.all
      %i[title author].each do |filter|
        mangas = mangas.send(filter, params[filter]) if params[filter]
      end
      mangas.map { |m|  MangaSerializer.new(m) }.to_json
    end

    post '' do
      title = params[:title]
      author = params[:author]

      manga = Manga.create(title: title, author: author)
      MangaSerializer.new(manga).to_json
    end


    # This should be modified on final api
    before do
      content_type 'text/html'
    end
    get '/:title' do

      manga = Manga.find_by(title: params[:title])
      erb :manga_details, locals: { manga: manga }
    end
  end

  namespace '/chapters' do
    get '' do
      chapters = Chapter.all
      %i[title number].each do |filter|
        chapters = chapters.send(filter, params[filter]) if params[filter]
      end
      chapters.to_json
    end

    post '' do
      title = params[:title]
      number = params[:number]
      manga_id = params[:manga]
      pages = params[:pages].split()
      chapter = Chapter.create(title: title, number: number, manga_id: manga_id, pages:pages)
      chapter.to_json
    end
  end
end