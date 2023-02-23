# frozen_string_literal: true

class CreateTrucks < ActiveRecord::Migration[7.0]
  def change
    # Districts
    create_table :districts do |t|
      t.string :ru, null: false
      t.string :uk, null: false
      t.string :en, null: false
      t.string :he, null: false
    end

    # Districts company
    create_table :districts_users, id: false do |t|
      t.belongs_to :district
      t.belongs_to :user
    end

    # Districts trucks
    create_table :districts_trucks, id: false do |t|
      t.belongs_to :district
      t.belongs_to :truck
    end

    # Trucks
    create_table :trucks do |t|
      t.references :user, null: false, foreign_key: true
      t.float  :length, null: false
      t.float  :load_capacity, null: false
      t.float  :rating, null: false, default: 0
      t.float  :height, null: false
      t.float  :width, null: false
      t.integer :body_type, null: false
      t.integer :assembly, null: false
      t.integer :packing, null: false
      t.integer :views, null: false, default: 0
      t.boolean :published, null: false, default: true

      t.timestamps
    end
  end
end
