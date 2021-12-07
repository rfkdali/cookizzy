class Recipe < ApplicationRecord
  include PgSearch
  has_many :ingredients

  validates :name, presence: true

  pg_search_scope :search, against: :name
end
