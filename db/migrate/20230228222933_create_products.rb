# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  # Products
  create_table :products do |t|
    t.references :user, null: false, foreign_key: true
    t.references :category, null: false, foreign_key: true
    t.references :thing, null: false, foreign_key: true
    t.string :title, null: false
    t.string :description
    t.integer :condition, null: false
    t.integer :price, null: false
    t.integer :views, null: false, default: 0
    t.boolean :published, null: false, default: true
    t.boolean :sold, null: false, default: false

    t.timestamps
  end
end
