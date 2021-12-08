Rails.application.routes.draw do
  resources :recipes
  post 'recipes/search'
end
