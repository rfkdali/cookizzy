Rails.application.routes.draw do
  root :to => 'recipes#index'

  resources :recipes
  post 'recipes/search'
end
