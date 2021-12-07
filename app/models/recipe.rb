class Recipe < ApplicationRecord
  include PgSearch::Model
  has_many :ingredients

  validates :name, presence: true

  pg_search_scope :search_by_ingredients,
    associated_against: {
      ingredients: :name_qty,
    },
    ignoring: :accents,
    using: {
      tsearch: {
        dictionary: "english",
        tsvector_column: "tsv",
      }
  }

  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: {
        dictionary: "english",
        tsvector_column: "tsv",
      }
  }
end
