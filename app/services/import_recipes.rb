require 'json'

class ImportRecipes
  attr_reader :recipes_path

  DEFAULT_PATH = 'public/assets/javascript/recipes.json'.freeze

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
    Recipe.create(JSON.parse(recipe_json))
  end
end
