class AddOtherColumnsToRecipe < ActiveRecord::Migration[6.1]
  RECIPE_COLUMNS = %i[rate author_tip budget prep_time author difficulty people_quantity cook_time tags total_time image nb_comments].freeze

  def change
    RECIPE_COLUMNS.each do |recipe_column|
      add_column :recipes, recipe_column, :string
    end
  end
end
