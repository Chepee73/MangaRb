require 'mongoid'

class Chapter
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :number, type: Integer
  field :title, type: String
  field :pages, type: Array

  validates :number, presence: true, numericality: { greater_than: 0 }

  belongs_to :manga
  index( { number: 1, manga_id: 1 }, unique: true, name: 'number_index')
end