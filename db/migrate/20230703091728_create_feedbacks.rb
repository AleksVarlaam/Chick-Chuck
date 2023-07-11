# frozen_string_literal: true

class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def up
    create_table :feedbacks do |t|
      t.float      :usability, null: false, default: 0
      t.float      :speed, null: false, default: 0
      t.float      :design, null: false, default: 0
      t.float      :quality, null: false, default: 0
      t.boolean    :informative, null: false
      t.boolean    :problems, null: false
      t.string     :title
      t.text       :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :feedbacks
  end
end
