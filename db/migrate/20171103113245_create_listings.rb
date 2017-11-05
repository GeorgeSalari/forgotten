class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :short_content
      t.string :full_content
      t.belongs_to :user, foreign_key: true, index: true
      t.integer :view_count, default: 0
      t.timestamps
    end
  end
end
