Rails.application.routes.draw do
	devise_for :users

	root 'intuits#index'

	get 'intuits/private'

end
