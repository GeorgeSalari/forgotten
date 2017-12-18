class CreatePlayerLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :player_levels do |t|
      t.integer :level
      t.integer :money
      t.integer :experience
      t.integer :stat
    end
  end
end
