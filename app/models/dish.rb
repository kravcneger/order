class Dish < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 255 }, uniqueness: true
  has_many :compositions
  has_many :ingredients, through: :compositions
end