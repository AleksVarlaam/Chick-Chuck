# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def up
    create_table :comments do |t|
      t.text :content
      t.references :user, null: true, foreign_key: true
      t.references :object, polymorphic: true, null: false
      t.references :commentable, polymorphic: true, null: false
      t.json       :images

      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
