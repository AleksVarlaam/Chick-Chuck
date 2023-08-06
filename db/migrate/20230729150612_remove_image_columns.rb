# frozen_string_literal: true

class RemoveImageColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :images
    remove_column :products, :images
    remove_column :news, :images
    remove_column :comments, :images
    remove_column :messages, :images
  end
end
