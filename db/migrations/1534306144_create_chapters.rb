# frozen_string_literal: true


Sequel.migration do
  change do
    create_table(:chapters) do
      primary_key :id
      String :title
      Integer :number
      foreign_key :manga_id, :mangas, null: false
    end
  end
end