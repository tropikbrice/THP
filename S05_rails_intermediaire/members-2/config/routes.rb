# https://wicked-pirate-39580.herokuapp.com/
# https://git.heroku.com/wicked-pirate-39580.git

Rails.application.routes.draw do

  	root 'users#index'

  	# get "/homepage" , to: 	"users#index"

	get  '/signup',  to: 'users#new'
	post '/signup',  to: 'users#create'

	get 'users/show'

	get 'users/edit'

	get 'users/update'

	get 'users/destroy'

	resources :users 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
