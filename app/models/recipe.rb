class Recipe < ApplicationRecord
  include PgSearch::Model

  validates :name, presence: true
  validates :ingredients, presence: true

  pg_search_scope :search_by_ingredients,
    against: :ingredients,
    ignoring: :accents,
    using: {
      tsearch: {
        dictionary: 'french',
        tsvector_column: "tsv",
        prefix: true
      }
  }
end
