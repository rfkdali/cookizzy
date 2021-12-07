class Recipe < ApplicationRecord
  include PgSearch::Model
  has_many :ingredients

  validates :name, presence: true

  pg_search_scope :search, against: :name, using: {
    tsearch: {
      dictionary: "english",
      tsvector_column: "tsv",
    }
  }


end
