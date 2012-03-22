Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :name, :null=>false
      String :email, :null=>false
      String :encrypted_password, :null=>false
      Time :created_at
      Time :updated_at
    end
  end
end
