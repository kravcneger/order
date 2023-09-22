class Ingredient < ApplicationRecord
	validates :name, length: { minimum: 2, maximum: 255 }, uniqueness: true
  has_many :dish_ingredients
  has_many :dishes, through: :dish_ingredients
end