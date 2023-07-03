class CreateReviews < ActiveRecord::Migration[7.0]
  def up
    create_table :reviews do |t|
      t.integer    :rating, null: false, default: 0
      t.integer    :price,  null: false, default: 0
      t.string     :title
      t.text       :content
      t.references :user, null: false, foreign_key: true
      t.references :reviewable, polymorphic: true, null: false

      t.timestamps
    end
  end
  
  def down
    drop_table :reviews
  end
end
