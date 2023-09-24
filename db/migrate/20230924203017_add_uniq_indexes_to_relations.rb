class AddUniqIndexesToRelations < ActiveRecord::Migration[7.0]
  def change
		add_index :exclusions, [:subscriber_id, :ingredient_id], unique: true
		add_index :compositions, [:dish_id, :ingredient_id], unique: true
  end
end
