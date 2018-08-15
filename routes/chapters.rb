before do
  content_type 'application/json'
end
namespace '/chapters' do
  get '' do
    chapters = Chapter.all
    %i[title number].each do |filter|
      chapters = chapters.send(filter, params[filter]) if params[filter]
    end
    chapters.to_api
  end

  post '' do
    title = params[:title]
    number = params[:number]
    manga_id = params[:manga]
    pages = params[:pages].split()
    chapter = Chapter.create(title: title, number: number, manga_id: manga_id, pages:pages)
    chapter.to_api
  end
end