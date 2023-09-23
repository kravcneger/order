class Ingredient < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 255 }, uniqueness: true
  has_many :compositions
  has_many :dishes, through: :compositions

	# Намеренно ушёл от использования полиморфной связи
  has_many :exclusions
  has_many :subscribers, through: :exclusions
end