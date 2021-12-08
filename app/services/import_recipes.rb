require 'json'

class ImportRecipes
  attr_reader :recipes_path

  DEFAULT_PATH = 'lib/assets/recipes.json'.freeze

  def initialize(recipes_path = DEFAULT_PATH)
    @recipes_path = recipes_path
  end

  def call
    # Use stream to avoid to load the entire file to memory
    IO.foreach(recipes_path) do |recipe_json|
      CreateRecipeWorker.perform_async(recipe_json)
    end
  end

  def create_recipe(recipe_json)
    recipe_attrs = parsed_recipe(recipe_json)
    Recipe.create(recipe_attrs)
  end

  private

  def parsed_recipe(recipe_json)
    recipe_hash = JSON.parse(recipe_json)
    recipe_hash['ingredients'] = recipe_hash['ingredients'].join(', ')
    recipe_hash
  end
end
