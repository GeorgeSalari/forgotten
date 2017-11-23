class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :topic, foreign_key: true, index: true
      t.belongs_to :theme, foreign_key: true, index: true

      t.timestamps
    end
  end
end
