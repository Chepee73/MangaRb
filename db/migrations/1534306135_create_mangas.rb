# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:mangas) do
      primary_key :id
      String :title, null: false
      String :author
      Date :release_date
      String :cover_url
    end
  end
end