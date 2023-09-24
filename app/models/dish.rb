class Dish < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 255 }, uniqueness: true
  has_many :compositions
  has_many :ingredients, through: :compositions
    
  def self.get_orders
    query = "
    WITH exclude_table AS (
      Select exclusions.ingredient_id, COALESCE(count(exclusions.ingredient_id),0) as ex_count
      FROM exclusions 
      GROUP BY  exclusions.ingredient_id
    ),
    sub_count AS(
      Select count(*) AS cnt from subscribers
    ),
    orders AS(
    Select d.id AS id, d.name AS name, ((select cnt from sub_count) - COALESCE(max(ex_count),0)) AS count  FROM dishes d
      LEFT JOIN compositions c ON c.dish_id = d.id
      LEFT JOIN exclude_table ex_in ON c.ingredient_id = ex_in.ingredient_id
      GROUP BY d.id, d.name			
      ORDER BY count DESC, name ASC)
    Select * from orders where count <> 0
    "
    ActiveRecord::Base.connection.execute(query).to_a
  end
end