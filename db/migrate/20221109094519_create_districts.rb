# frozen_string_literal: true

class CreateDistricts < ActiveRecord::Migration[7.0]
  def change
    # Districts
    create_table :districts do |t|
      t.string :ru, null: false
      t.string :uk, null: false
      t.string :en, null: false
      t.string :he, null: false
    end

    # Cities
    create_table :cities do |t|
      t.string :ru, null: false
      t.string :en, null: false
      t.string :uk, null: false
      t.string :he, null: false
      t.references :district, null: false, foreign_key: true
    end
  end
end
