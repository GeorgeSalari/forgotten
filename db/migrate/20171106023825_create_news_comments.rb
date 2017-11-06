class CreateNewsComments < ActiveRecord::Migration[5.1]
  def change
    create_table :news_comments do |t|
      t.belongs_to :listing
      t.belongs_to :user
      t.string :quote_head
      t.string :quote_content
      t.string :content
      t.timestamps
    end
  end
end
