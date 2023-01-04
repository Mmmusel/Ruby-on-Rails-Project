class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :business_id
      t.string :order_name
      t.string :order_address
      t.string :order_mobile
      t.string :order_status
      t.decimal :order_sum

      t.timestamps
    end
  end
end
