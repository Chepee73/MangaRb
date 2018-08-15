before do
  content_type 'application/json'
end
namespace '/mangas' do
  get '' do
    mangas = Manga.all
    %i[title author].each do |filter|
      mangas = mangas.send(filter, params[filter]) if params[filter]
    end
    mangas.map { |m| m.to_api }.to_json
  end

  post '' do
    title = params[:title]
    author = params[:author]

    manga = Manga.create(title: title, author: author)
    manga.to_api
  end


  # This should be modified on final api
  before do
    content_type 'text/html'
  end
  get '/:title' do
    manga = Manga.where(title: params[:title]).first
    erb :manga_details, locals: { manga: manga }
  end
end