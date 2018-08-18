namespace "/api/chapters" do
  before do
    content_type "application/json"
  end
  get ROOT do
    chapters = Chapter.all
    %i[title number].each do |filter|
      chapters = chapters.send(filter, params[filter]) if params[filter]
    end
    chapters.map { |c| c.to_api}.to_json
  end

  post ROOT do
    title = params[:title]
    number = params[:number]
    manga_id = params[:manga]
    pages = params[:pages].split()

    chapter = Chapter.create(title: title, number: number, manga_id: manga_id)

    pages.each_with_index do |page, i|
      chapter.add_page(number: i, url: page)
    end

    chapter.save

    chapter.to_api.to_json
  end

  get "/:id" do
    chapter = Chapter.find(id: params[:id])
    chapter.to_api.to_json
  end
end