class CreateOrderitems < ActiveRecord::Migration[7.0]
  def change
    create_table :orderitems do |t|
      t.integer :order_id
      t.string :title
      t.decimal :price
      t.integer :num
      t.string :image

      t.timestamps
    end
  end
end
