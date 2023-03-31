# frozen_string_literal: true

class CreateCatalogAndCalculator < ActiveRecord::Migration[7.0]
  def change
    # Categories
    create_table :categories do |t|
      t.string :ru, null: false
      t.string :uk, null: false
      t.string :en, null: false
      t.string :he, null: false
      t.string :category
    end

    # Things
    create_table :things do |t|
      t.references :category, null: false, foreign_key: true
      t.string :ru, null: false
      t.string :uk, null: false
      t.string :en, null: false
      t.string :he, null: false
    end

    # Prices
    create_table :prices do |t|
      t.references :thing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float      :amount, null: false
    end

    # Calculators
    create_table :calculators do |t|
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.float :distance, null: false
      t.float :floor_down, null: false
      t.float :floor_down_elevator, null: false
      t.float :floor_up, null: false
      t.float :floor_up_elevator, null: false
    end
  end
end
