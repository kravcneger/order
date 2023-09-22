class Ingredient < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 255 }, uniqueness: true
  has_many :compositions
  has_many :dishes, through: :compositions
end