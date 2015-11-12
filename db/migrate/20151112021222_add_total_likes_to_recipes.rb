class AddTotalLikesToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :total_likes, :integer
  end
end
