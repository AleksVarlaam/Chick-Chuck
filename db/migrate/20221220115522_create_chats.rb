# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[7.0]
  def change
    # Rooms
    create_table :rooms do |t|
      t.string :title, null: false

      t.timestamps
    end

    # Rooms - Users
    create_table :rooms_users, id: false do |t|
      t.belongs_to :room
      t.belongs_to :user
    end

    # Messages
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.text       :content
      t.boolean    :readed, default: false

      t.timestamps
    end
  end
end
