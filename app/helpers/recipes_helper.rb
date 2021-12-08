module RecipesHelper
  def ingredients_list(ingredients)
    JSON.parse(ingredients)
  end
end
