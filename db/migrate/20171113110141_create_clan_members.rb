class CreateClanMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :clan_members do |t|
      t.string :race
      t.string :nick_name
      t.string :player_link
      t.integer :player_level
      t.string :player_post
      t.string :city
      t.string :name
      t.date :birthday
      t.string :department
      t.timestamps
    end
  end
end
