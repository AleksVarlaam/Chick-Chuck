class AddCityToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :city
    remove_column :users,    :city
    add_reference :users,    :city, null: true, foreign_key: true
  end
end
