Edsk::Application.routes.draw do

  # Fancy routes
  match "/image/:id" => "viewer#image"
  match "/video/:id" => "viewer#video"
  match "/editor/:id" => "texteditor#edit"
  match "/get/:id" => "nodes#show"
  post "texteditor/save"
  get "texteditor/create"
  
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
