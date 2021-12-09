class Recipe < ApplicationRecord
  include PgSearch::Model

  # paginates_per 25

  validates :name, presence: true
  validates :ingredients, presence: true

  pg_search_scope :search_by_ingredients,
    against: :ingredients,
    ignoring: :accents,
    using: {
      tsearch: {
        dictionary: 'french',
        prefix: true
      }
  }
end
