require 'mongoid'

class Manga
  include Mongoid::Document

  field :title, type: String
  field :author, type: String
  field :release_date, type: Date
  field :cover_url, type: String

  validates :title, presence: true

  index(title: 'text')

  scope :title, ->(title) {where(title: /#{title}/i)}
  scope :author, ->(author) {where(author: /#{author}/i)}

  has_many :chapters

end

class MangaSerializer
  def initialize(manga)
    @manga = manga
  end

  def as_json(*)
    data = {
        id: @manga.id.to_s,
        author: @manga.author,
        title: @manga.title,
        cover_url: @manga.cover_url,
        release_date: @manga.release_date.to_s
    }
    data[:errors] = @manga.errors if @manga.errors.any?
    data
  end
end