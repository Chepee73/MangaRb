namespace "/api/mangas" do
  before do
    content_type "application/json"
  end
  get ROOT do
    mangas = Manga.all
    %i[title author].each do |filter|
      mangas = mangas.send(filter, params[filter]) if params[filter]
    end
    if mangas.length > 1
      mangas.map { |m| m.to_api }.to_json
    else
      mangas[0].to_api.to_json
    end

  end

  post ROOT do
    title = params[:title]
    author = params[:author]

    p params

    manga = Manga.create(title: title, author: author)
    p manga
    manga.to_api.to_json
  end
end