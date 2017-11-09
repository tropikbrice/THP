#cree app:
rails new thread_eval_proc-gossip-project

#cree le modele
rails generate model Gossip
# => ça a créé un fichier de migration /migrate/20171024224414_create_gossips.rb
#rajout des colonnes de la database dans ce fichier 20171024224414_create_gossips.rb
#on sauvegarde

#on va executer l'ajout de ces news colonnes dans la DB, cad :
# => on a fait la "migration" (pr lui dire qu'on a fait les modifs)
rails db:migrate

# créé le controller, en faisant
rails generate controller Gossips

#brancher les routes pour que le CRUD entier de notre model gossip marche
# => on va dans /config/routes.rb

#par rapport au MVC :
# il faut regler
# -les routes
# -le controller "de gossips"
# -il faut que le controller aille chercher avec le Model (dans les DB)
# -et enfin regler la View pour afficher le tout
# => faire le CRUD

# on commence par regler les routes :
#on fait le resources
resources :gossips
# => donne le CRUD entier ds les routes

# voir l'état des routes dans rails
rails routes


rails generate controller Users index new show edit update destroy create

rails generate controller Pages homepage


#########################################################################################
#########################################################################################
Rails.application.routes.draw do
	root 'gossips#index'

	get "new", to: 'gossips#new'

	# get 'create', to: 'gossips#create'

	get 'show', to: 'gossips#show'

	resources :gossips

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

#########################################################################################
#########################################################################################
class GossipsController < ApplicationController
	def index
		@gossips = Gossip.all
	end

	def new
		@gossip = Gossip.new
		# @gossip.anonymous_author = "type your anonymous user"
		# @gossip.content = "write your fucking gossip!"
		# @gossip.save
		# @gossip.anonymous_author = 
	end

	def show
		@gossip = Gossip.find(params[:id])
		#puts "id = #{@gossip.id} "
		# puts "your gossip : #{@gossip}"
	end

	def edit
		@gossip = Gossip.find(params[:id])
	end

	def update
		@gossip = Gossip.find(params[:id])

		if @gossip.update(gossip_params)
			redirect_to @gossip
		else
			render "Edit"
		end		
	end

	def destroy
		@gossip = Gossip.find(params[:id])
		@gossip.destroy
		redirect_to gossips_path
	end

	def create
		@gossip = Gossip.new(gossip_params)
		if @gossip.save
			redirect_to @gossip
		else
			render "new"
		end
	end

	private
		def gossip_params
			params.require(:gossip).permit(:anonymous_author, :content)
		end
end
#########################################################################################
#########################################################################################

initialise git, crée un repo Github et ajoute ce repo en origin
heroku create
git push heroku master

$ git push heroku master
$ heroku run rails db:migrate
