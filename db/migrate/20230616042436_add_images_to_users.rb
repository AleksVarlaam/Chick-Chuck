# frozen_string_literal: true

class AddImagesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :images, :json
  end
end
