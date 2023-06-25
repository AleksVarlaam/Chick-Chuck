# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :ru, null: false
      t.string :uk, null: false
      t.string :en, null: false
      t.string :he, null: false
    end

    # Services company
    create_table :services_users, id: false do |t|
      t.belongs_to :service
      t.belongs_to :user
    end
  end
end
