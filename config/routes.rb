Edsk::Application.routes.draw do
  devise_for :users
  resources :nodes do
  	collection do
	 get 'search'
	 get 'table' 
	 post 'dnd'
	end
  end
  root :to => "nodes#index"
end
