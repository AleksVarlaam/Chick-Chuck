# frozen_string_literal: true

class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :published, null: false, default: true
      t.integer :views, null: false, default: 0

      t.timestamps
    end
  end
end
