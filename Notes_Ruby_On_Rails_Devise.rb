# creation new app :
rails new testDevise && cd testDevise

#on reprend notre gem file national, lol, et on rajout dans gemfile
# devise omniauth
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'

# on n'oublie pas le git !!
# git init
# git add .
#  git commit -m 'initial commit'

#on va demander au generateur d'installer les gem
bundle install
#une fois la gem installe, ft installer devise:
rails g devise:install

####################################################
	# TOUT CA C INUTILE SI PAS DE TESTE ENVOI MAIL
	# on commence par configurer systeme emailing
	# en env de dev pour mettre en local
	# ouvrir fichier development.rb
	# ajouter :
	# ne surtout pas la rajouter au gemfile : ça fout la merde !!!
	# il faut l'installer :
	# gem install mailcatcher
	# puis lancer : mailcatcher
	# goto localhost:1080
	# envoyer mail : smtp://localhost:1025

	# Mailer dans development.rb
	config.action_mailer.delivery_method = :smtp
	config.action_mailer.smtp_settings = {
		adress: 'localhost',
		port: 1025
	}
	# config.action_mailer.default_url_options = { host: 'local.dev', port: 3000}
	config.action_mailer.default_url_options = { host: 'localhost', port: 3000}

	#adresse mail dev
	local.dev:3000 
####################################################

#on cree un controller simple (naming au pluriel pour les controller!!!) pr avoir des routes 
rails g controller Home index private

# on genere les views pr devise comme le suggere
# l'install de rails g devise:install:
rails g devise:views

# place au model des utilisateurs : c devise qui genere le modele
rails g devise User
	# si on veut rajouter des comportements les ajouter au user.rb
	ex: :confirmable => rajouter des info supp, cf les info en commentaire dans le fichier de migration
#on fait migration :
rails db:migrate

# ya plein de trucs sympas qui se sont crees : tout en fait lol

# je fias un coup de action mailer car j'arrivais pas à voir le mail de confirmation envoyé
rails g mailer ContactMailer
# go to contact_mailer.rb , ajout ds la class ContactMailer de :
	def contact
		mail(to: 'contact@test.fr', subject: 'Sujet de test')
	end
# Contact_mailer_preview.rb permet de verifier et analyser les emails
#creation d'une new preview pr email 
	def contact
		ContactMailer.contact()		
	end
# puis on cree les vues associees  
# ds dossier views/contact_mailer
contact.html.erb
contact.text.erb
# et on ecrit ce qu'on veut dans ces vues precedentes
# ON FAIT UN TEST :
# ds le preview il n'y a pas d'arguments
# on rajoute dans
class ContactMailerPreview < ActionMailer::Preview
	def contact()
		ContactMailer.contact(User.first)		
	end
end
# et dans 
class ContactMailer < ApplicationMailer
	def contact(user)
		@user = user
		mail(to: 'contact@test.fr', subject: 'Sujet de test')
	end
end
# j'ai modifie le contact.html.erb pr lui dire de se logguer :
<h1>Bonjour</h1>
<h2><%= @user.email%></h2>

<p><%= link_to 'log in', new_user_session_url( host: 'localhost') %></p>

<p>sa ki ni ?</p>
#  ajout a la fin de dans application.rb
config.action_mailer.default_url_options = { host: 'local.dev', port: 3000}

############################################

 #on place les alertes comme préconisées par rails dans application.html.erb - body :
	<p class="notice"><%= notice %></p>
	<p class="alert"><%= alert %></p>

# dans devise.rb changer le 
	config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'



# modifier le application_controller.rb pr accepter les nouveaux champs
class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_action :configure_devise_parameters , if: :devise_controller?

	def configure_devise_parameters
		devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:username , :email , :password, :password_confirmation, :phone)}
	end
end
