class Chapter < Sequel::Model
  many_to_one :mangas
  one_to_many :pages

  def to_api
    {
        title: title,
        number: number,
        pages: pages.map { |p| p.url }
    }
  end
end