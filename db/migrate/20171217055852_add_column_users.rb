class AddColumnUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reset_password_token, :string, default: ''
  end
end