class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name_qty, presence: true
end
