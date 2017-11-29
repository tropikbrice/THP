# on ajoute gem figaro pour gerer les key caches dans gemfile
# on installe figaro
bundle exec figaro install
# => creation de fichier config/applications.yml et .gitignore

# Pour le deploiement sur Heroku :
# https://github.com/laserlemon/figaro
# Heroku
# Heroku already makes setting application configuration easy:

# $ heroku config:set google_analytics_key=UA-35722661-5
# Using the figaro command, you can set values from your configuration file all at once:

# $ figaro heroku:set -e production
# For more information:

# $ figaro help heroku:set


# apres bundle update :
# on genere un controlleur avec une methode index afin d'afficher la page avec gmaps
rails g controller Maps index

# configuration des routes
# => config/routes.rb

##########
# on s'attaque aux view now

# parametrage des api_key de google maps en mode secret via secrets.yml

# on copie le script d'appel à l'API dans /maps/index.html.erb
# puis on l'appelle via :
	# <script src="https://maps.googleapis.com/maps/api/js?key=<%=Figaro.env.google_api_key%> &callback=initMap" async defer></script>
# directement dans le code html a la fin du code

##############
# on cree la partie html du formulaire : cf code dans index.html.erb

########## JS
# on va faire du js dans un fichier separe pr que ça soit propre le html.erb
# => on cree un fichier : ATTENTION , il faut creer dossier nomController !!!!
/app/assets/javascripts/maps/maps.js
# on va tout de suite l ajouter à rails pour qu'il le precompile dans le fichier
/config/initializers/assets.rb

# on copie le bout de code pris sur site google maps : https://developers.google.com/maps/documentation/javascript/examples/map-simple?hl=fr
#       var map;
#       function initMap() {
#         map = new google.maps.Map(document.getElementById('map'), {
#           center: {lat: -34.397, lng: 150.644},
#           zoom: 8
#         });
#       }
# }

# on copie 
#     <div id="map"></div>
# dans la view index.html

# bon j'ai un peu saute bcp de choses, en gros :
# Asset was not declared to be precompiled in production.
# Add `Rails.application.config.assets.precompile += %w( maps.js )` to `config/initializers/assets.rb` and restart your server

# pour le cas des js : marker, event if clic, ...
# cf https://www.w3schools.com/graphics/google_maps_events.asp

# faut creer un modele pour stocker donnees lat long message !
rails generate model Map