class AddColumnToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :posts_count, :integer, default: 0
  end
end
