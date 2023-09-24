class CreateIngredientsDishes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :dishes, :ingredients, table_name: :compositions do |t|
      t.index :dish_id
      t.index :ingredient_id
    end
    add_foreign_key :compositions, :dishes, column: :dish_id
    add_foreign_key :compositions, :ingredients, column: :ingredient_id
  end
end
