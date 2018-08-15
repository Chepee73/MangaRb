namespace "/chapters" do
  before do
    content_type "application/json"
  end
  get ROOT do
    chapters = Chapter.all
    %i[title number].each do |filter|
      chapters = chapters.send(filter, params[filter]) if params[filter]
    end
    chapters.to_json
  end

  post ROOT do
    title = params[:title]
    number = params[:number]
    manga_id = params[:manga]
    pages = params[:pages].split()

    chapter = Chapter.create(title: title, number: number, manga_id: manga_id)

    pages.each_with_index do |page, i|
      chapter.add_page(Page.create(number:i, url:page, chapter_id: chapter.id))
    end

    chapter.save

    chapter.to_api
  end
end