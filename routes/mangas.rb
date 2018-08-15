namespace '/mangas' do
  before do
    content_type 'application/json'
  end
  get ROOT do
    mangas = Manga.all
    %i[title author].each do |filter|
      mangas = mangas.send(filter, params[filter]) if params[filter]
    end
    mangas.map { |m| m.to_api }.to_json
  end

  post ROOT do
    title = params[:title]
    author = params[:author]

    p params

    manga = Manga.create(title: title, author: author)
    p manga
    manga.to_api
  end


  get '/:title' do
    manga = Manga.where(title: params[:title]).first
    erb :manga_details, locals: { manga: manga }
  end
end