Sequel.migration do
  change do
    create_table(:pages) do
      primary_key :id
      foreign_key :chapter_id, :chapters, null: false
      Integer :number, null: false
      String :url, null: false
    end
  end
end