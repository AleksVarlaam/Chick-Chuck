class AddViewsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :views, :integer, default: 0
    add_column :users, :price, :float,   default: 0
  end
end
