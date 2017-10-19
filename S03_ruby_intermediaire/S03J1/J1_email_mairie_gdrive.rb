#!/usr/bin/env ruby

# jouer avec la gem google_drive

require "google_drive"
require "pry"
require_relative "/home/brice/Documents/THP/S02J04/rte_mairie.rb"

session = GoogleDrive::Session.from_config("client_secret.json")

#on recupere le fichier mairie de notre drive
fichier_mairie = session.spreadsheet_by_title("mairie")

#creer une def qui recupere les emails, noms scrapés
def get_email_hash()
	page_url = "http://annuaire-des-mairies.com/val-d-oise.html"

	#appel de la fonction contenue dans le fichier route mairie, autre repertoire, via le require_relative du debut de ce fichier
	return get_email_name(page_url)
end


# #tab est un tableau car la fonction de scrapp retourne un tableau de hashs
#tab= get_email_hash()

def get_the_name_and_email_and_put_it_in_spreadsheet(fichier_mairie, tab)
	#je me positionne dans le 1er onglet de mon fichier spreadsheet drive (excel drive)
	#onglet1 = fichier_mairie.worksheets.first
	onglet1 = fichier_mairie.worksheets[0]

	#notre tableau de hash de nom mairie , email = tab
	# tab[15]
	# => {:name=>"BEAUCHAMP",
	#  :email=>"accueil-mairie@ville-beauchamp.fr"}

	# on demarre
	# i à 2 car la 1ere ligne est la ligne qui contient les noms de colonne , i va de 2 à taille du tableau de hash soit 185+2=187
	i=2
	#binding.pry
	tab.each do |element_du_tab_est_hash|
		onglet1[i,1] = element_du_tab_est_hash[:name]

		onglet1[i,2] = element_du_tab_est_hash[:email]

		#incrementation des lignes "i" en dehors des boucles d'insertion des valeurs
		i += 1
	end

	onglet1.save
end

#utilisation de la fonction
get_the_name_and_email_and_put_it_in_spreadsheet(fichier_mairie , tab)