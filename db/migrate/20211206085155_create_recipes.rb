class CreateRecipes < ActiveRecord::Migration[6.1]
  RECIPE_COLUMNS = %i[name rate author_tip budget prep_time author difficulty people_quantity cook_time tags total_time image nb_comments].freeze

  def change
    create_table :recipes do |t|
      RECIPE_COLUMNS.each do |recipe_column|
        t.string recipe_column
      end

      t.text :ingredients

      t.timestamps
    end
  end
end
