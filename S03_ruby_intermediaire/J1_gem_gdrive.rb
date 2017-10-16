#!/usr/bin/env ruby

# jouer avec la gem google_drive

require "google_drive"
require "pry"
require_relative "/home/brice/Documents/THP/S02J04/rte_mairie.rb"

session = GoogleDrive::Session.from_config("client_secret.json")


# permet de lister les fichier presents sur le repertoire racine de Drive 
# session.files.each do |file|
# 	p file.title
# end

# # Get the spreadsheet by its title
# spreadsheet = session.spreadsheet_by_title("Achat-data")

# # Get the first worksheet
# worksheet = spreadsheet.worksheets.first
# # Print out the first 6 columns of each row
# worksheet.rows.each { |row| puts row.first(6).join(" | ") }

#on recupere le fichier mairie de notre drive
fichier_mairie = session.spreadsheet_by_title("mairie")

#creer une def qui recupere les emails, noms scrapés

def get_email_hash()
	
	binding.pry

	puts townhall_list

end


#tab est un tableau car la fonction de scrapp retourne un tableau de hashs
tab= get_email_hash()

def get_the_name_and_put_it_in_spreadsheet(fichier, param_hash)

end

#utilisation de la fonction
#get_the_name_and_put_it_in_spreadsheet(fichier_mairie , tab)
