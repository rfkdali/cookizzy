json.extract! ingredient, :id, :name_qty, :recipe_id, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
