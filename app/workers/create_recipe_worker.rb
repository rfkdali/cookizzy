class CreateRecipeWorker
  include Sidekiq::Worker

  def perform(recipe_json)
    ImportRecipes.new.create_recipe(recipe_json)
  end
end
