Rails.application.routes.draw do
  resources :ingredients
  resources :recipes
  post 'recipes/search'
end
