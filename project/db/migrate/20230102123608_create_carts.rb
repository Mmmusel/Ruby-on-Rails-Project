class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :blog_id
      t.integer :user_id
      t.integer :num

      t.timestamps
    end
  end
end
