class Subscriber < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true
  has_many :exclusions
  has_many :excluded_ingredients, through: :exclusions, source: :ingredient
end