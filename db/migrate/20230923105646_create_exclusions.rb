class CreateExclusions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :subscribers, :ingredients, table_name: :exclusions do |t|
      t.index :subscriber_id
      t.index :ingredient_id
    end
    add_foreign_key :exclusions, :subscribers, column: :subscriber_id
    add_foreign_key :exclusions, :ingredients, column: :ingredient_id
  end
end
