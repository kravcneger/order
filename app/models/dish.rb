class Dish < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 255 }, uniqueness: true
  has_many :compositions
  has_many :ingredients, through: :compositions
	
	def self.get_orders
		query = "
    WITH exclude_table AS (
      Select exclusions.ingredient_id, count(exclusions.ingredient_id) as ex_count
      FROM exclusions 
      GROUP BY  exclusions.ingredient_id
    ),
    sub_count AS(
      Select count(*) AS cnt from subscribers
    )  
    Select dishes.id, dishes.name, (select cnt from sub_count) - max(ex_count) AS count  FROM dishes
      LEFT JOIN compositions ON compositions.dish_id = dishes.id
      LEFT JOIN exclude_table ex_in ON compositions.ingredient_id = ex_in.ingredient_id
      GROUP BY dishes.id, dishes.name
      ORDER BY count DESC, name ASC"
    ActiveRecord::Base.connection.execute(query).to_a
  end
end