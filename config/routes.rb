Edsk::Application.routes.draw do

  get "viewer/image"
  get "texteditor/edit"
  post "texteditor/save"

  devise_for :users
  resources :nodes do
  	collection do
	 post 'search'
	 get 'table' 
	 post 'dnd'
	end
  end
  root :to => "nodes#index"
end
