ENV['RACK_ENV'] = 'test'


require './main'
require 'minitest/autorun'

require 'rack/test'

set :environment, :test

class ChapterModelTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_should_create_a_new_chapter
    @manga = Manga.create(title: 'One Piece', author: 'Eichiro Oda')
    count = Chapter.count
    Chapter.create(title: 'Romance Dawn', number: 1, manga_id: @manga.id)
    assert_equal count, Chapter.count
  end
end