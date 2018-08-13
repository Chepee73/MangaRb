require 'sinatra/namespace'
require './helpers/api_helpers'
get '/' do
  erb :index
end

get '/create' do
  erb :create
end

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
      chapters.to_json
    end
  end
end