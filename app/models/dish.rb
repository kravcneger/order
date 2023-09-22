class Dish < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 255 }, uniqueness: true
  has_many :dish_ingredients
  has_many :ingredients, through: :dish_ingredients
end