class CreateIngredientsDishes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :dishes, :ingredients do |t|
      t.index :dish_id
      t.index :ingredient_id
    end
  end
end
