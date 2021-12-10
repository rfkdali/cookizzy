Rails.application.routes.draw do
  root :to => 'homes#index'

  resources :recipes do
    get :search, on: :collection
  end
end
