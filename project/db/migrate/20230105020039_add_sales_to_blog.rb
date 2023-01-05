class AddSalesToBlog < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :sales, :integer
  end
end
