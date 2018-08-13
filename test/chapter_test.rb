# This will be an improvised test for now
#
#
#

require './main'
Chapter.remove_indexes
Chapter.create_indexes
Chapter.destroy_all
Chapter.create( {number: 1, manga_id: Manga.first.id })
Chapter.create( {number: 1, manga_id: Manga.last.id })
