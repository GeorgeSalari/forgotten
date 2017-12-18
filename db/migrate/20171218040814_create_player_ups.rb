class CreatePlayerUps < ActiveRecord::Migration[5.1]
  def change
    create_table :player_ups do |t|
      t.integer :up
      t.integer :money
      t.integer :stat
      t.integer :money
      t.integer :experience
      t.references :player_level, foreign_key: true
    end
  end
end
