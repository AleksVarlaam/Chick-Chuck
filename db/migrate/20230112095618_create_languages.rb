# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :languages do |t|
      t.string :title, null: false
    end

    create_table :languages_users, id: false do |t|
      t.belongs_to :language
      t.belongs_to :user
    end
  end
end
