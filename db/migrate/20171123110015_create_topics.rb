class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :group, foreign_key: true, index: true
      t.belongs_to :theme, foreign_key: true, index: true
      t.json :last_post
      t.integer :posts_count, default: 0

      t.timestamps
    end
  end
end
