Sequel.migration do
  change do
    create_table(:users) do
      String :uri
      String :slug, size: 25
      String :gravatar_id, fixed: true, size: 32
      String :username, null: false, size: 25, unique: true
      String :display_name, size: 25
      Fixnum :release_count, default: 0
      Fixnum :module_count, default: 0
      Time :created_at, default: Time.now
      Time :updated_at, default: Time.now
    end
  end
end
