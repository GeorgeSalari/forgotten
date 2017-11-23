class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.string :title
      t.belongs_to :group, foreign_key: true, index: true
      t.integer :topics_count, default: 0
      t.json :last_post

      t.timestamps
    end
  end
end
