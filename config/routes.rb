Rails.application.routes.draw do
  resources :ingredients
  resources :recipes
  get 'recipes/search/:name', to: 'recipes#search', as: 'search'

end
