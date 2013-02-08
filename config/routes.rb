Edsk::Application.routes.draw do
  devise_for :users
  resources :nodes do
  	collection { get 'search' }
  end
  root :to => "nodes#index"
end
