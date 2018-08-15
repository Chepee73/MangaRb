class Page < Sequel::Model
  many_to_one :chapters
end