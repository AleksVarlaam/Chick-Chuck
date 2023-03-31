# frozen_string_literal: true

class CreateStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :statistics do |t|
      t.integer :main, default: 0
      t.integer :calculator, default: 0
      t.integer :trucks, default: 0
      t.integer :market, default: 0
      t.integer :about, default: 0
      t.integer :mooving_preparation, default: 0
      t.integer :news, default: 0

      t.timestamps
    end
  end
end
