Sequel.migration do
  change do
    create_table(:repositories) do
      primary_key :id
      foreign_key :user_id
      String :name, :null=>false
      String :homepage
      String :description
      Boolean :private_flag, :default=> false
      Time :created_at
      Time :updated_at
    end
  end
end

