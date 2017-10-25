#cree app:
rails new the-gossip-project

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