class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.integer :serving_size
      t.string :cook_time
      t.string :ingredients
      t.string :method
      t.integer :user_id
    end
  end
end
