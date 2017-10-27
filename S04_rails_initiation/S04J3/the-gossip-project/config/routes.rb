Rails.application.routes.draw do
	root 'gossips#index'

	get "new", to: 'gossips#new'

	# get 'create', to: 'gossips#create'

	get 'show', to: 'gossips#show'

	resources :gossips

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end