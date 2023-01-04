class AddCommandToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :commands, :string
  end
end
