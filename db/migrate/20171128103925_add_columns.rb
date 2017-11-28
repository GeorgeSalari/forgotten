class AddColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :acces_for_all, :boolean, default: true
    add_column :themes, :acces_for_all, :boolean, default: true
    add_column :topics, :acces_for_all, :boolean, default: true
  end
end
