# frozen_string_literal: true

class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    # Comments
    create_table :comments do |t|
      t.text :content
      t.references :user, null: true, foreign_key: true
      t.references :object, polymorphic: true, null: false
      t.references :commentable, polymorphic: true, null: false
      t.json       :images

      t.timestamps
    end

    # Reviews
    create_table :reviews do |t|
      t.integer    :rating, null: false, default: 0
      t.text       :content
      t.references :user, null: false, foreign_key: true
      t.references :reviewable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
