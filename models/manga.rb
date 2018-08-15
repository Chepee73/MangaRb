class Manga < Sequel::Model
  one_to_many :chapters

  def to_api
    {
      title: title,
      author: author,
      chapters: chapters.map { |c| c.id }
    }
  end
end