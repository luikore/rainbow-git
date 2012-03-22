Sequel.migration do
  change do
    add_column :users, :reset_password_token, String
    add_column :users, :fast_login_token,     String
    add_column :users, :confirmed_at,         Date
  end
end
