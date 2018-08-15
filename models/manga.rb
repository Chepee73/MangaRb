class Manga < Sequel::Model
  one_to_many :chapters

  def to_api
    {
        title: title,
        author: author,
        chapters: chapters
    }
  end
end