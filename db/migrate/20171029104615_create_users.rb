class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.integer :role
      t.string :email
      t.string :password_digest
      t.string :gender
      t.date :birthday
      t.string :profile_photo
      t.timestamps
    end
  end
end
