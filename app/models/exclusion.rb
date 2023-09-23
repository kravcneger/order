class Exclusion < ApplicationRecord
  belongs_to :subscriber
  belongs_to :ingredient
end