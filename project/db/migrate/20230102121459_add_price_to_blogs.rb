class AddPriceToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :price, :decimal
  end
end
