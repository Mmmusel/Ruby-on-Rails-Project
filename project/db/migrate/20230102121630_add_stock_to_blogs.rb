class AddStockToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :stock, :integer
  end
end
