Rails.application.routes.draw do
  root :to => 'homes#index'

  resources :recipes
  post 'recipes/search'
end
