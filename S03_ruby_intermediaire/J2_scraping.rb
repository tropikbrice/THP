#!/usr/bin/env ruby

#Scrapping
#récupérer les adresses emails des mairies du 23
#voire un ou plusieurs autres départements
# Le programme ira engregistrer tous tes scrappings dans un beau fichier Google Spreadsheet

require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require "google_drive"
require "pry"
require 'gmail'

class Scraping
	#class de fonctions permettant de realiser du scraping des mairies de france
	#via l'url

	attr_accessor :page_url

	def initialize(page_url)
		@page_url = "http://annuaire-des-mairies.com/creuse.html"
	end

	#récupère l'adresse email à partir de l'url d'une mairie
	#pour plus de details sur la construction des fonctions :
	#cf fichier rte_mairie.rb
	def get_the_email_of_a_townhall_from_its_webpage(page_url_one_townhall)
		page = Nokogiri::HTML(open(page_url_one_townhall))

		#recuperation de l'email en "parsant" le html via XPATH
		email_pos = page.xpath('//td[@class="style27"]/p[@class="Style22"]')

		#afin de gerer les index des adresses vides on fait un ||= "" pour le retour de find_index
		index_email = email_pos.text.split("\u00A0").find_index{|x| x.include?("@")}
		index_email ||= 0

		email= email_pos.text.split("\u00A0")[index_email]
		return email
	end

	#récupère toutes les url de villes du departement
	#en retournant un hash contenant url pour chaque ville
	def get_all_the_urls_of_department_townhalls(page_url_dpt)
		page = Nokogiri::HTML(open(page_url_dpt))

		url = page.xpath('//a[@class="lientxt"]')

		#initialisation de la list en mode tableau
		list_url = []
		#on enregistre chaque url dans un hash : {townhall_name , url}
		url.each do |x|
			list_url << { name:x.text, url:"http://annuaire-des-mairies.com" + x[:href][1..-1] }	
		end
		return list_url
	end

	#retourne un tableau de hash contenant les emails/nom_mairie
	#un hash est defini ainsi {cle=nom_mairie , valeur = email_mairie}
	#cette fonction appelle les 2 fonctions precedentes
	def get_email_name(page_url_dpt)

		townhall_list = []
		get_all_the_urls_of_department_townhalls(page_url_dpt).each do |x|
			#il y avait une erreur de mail non renseigne , vu grace aux instructions ci dessous
			#donc on doit traiter les emails vides : ok fait ds la def de la fonction cidessus
			# puts "--------"
			#puts x[:url]

			email_ville=get_the_email_of_a_townhall_from_its_webpage( x[:url])
			#puts x[:url]

			townhall_list << { x[:name] => email_ville }
		end
		return townhall_list
	end
end

####################################################################################
####################################################################################
####################################################################################
#classe de fonctions concernant google drive
class Drive

	#enregistrement dans un spreadsheet
	def login_drive(session)
		@session ||= GoogleDrive::Session.from_config("client_secret.json")
	end

	#tab est un tableau car la fonction de scrapp retourne un tableau de hashs
	#tab= get_email_hash()
	def get_the_name_and_email_and_put_it_in_spreadsheet(session, excel, tab)

		#on recupere le fichier mairie de notre drive
		townhall_file = session.spreadsheet_by_title(excel)

		#je me positionne dans le 1er onglet de mon fichier spreadsheet drive (excel drive)
		onglet1 = townhall_file.worksheets[0]

		# on demarre
		# i à 2 car la 1ere ligne est la ligne qui contient les noms de colonne , i va de 2 à taille du tableau de hash soit 185+2=187
		# le hash est sous cette forme {nom_mairie:email_mairie}
		i=2
		#binding.pry
		tab.each do |element_du_tab_est_hash|
			element_du_tab_est_hash.each do |k,v|
				onglet1[i,1] = k
				onglet1[i,2] = v
			end
			#incrementation des lignes "i" en dehors des boucles d'insertion des valeurs
			i += 1
		end
		#on envoie les donnees au sheet drive :
		onglet1.save
		return onglet1
	end

	#fonction qui recupere juste le 1er ongler d un spreadsheet (pour pouvoir faire test)
	def get_spreadsheet(session, excel)
		#on recupere le fichier de notre drive
		file = session.spreadsheet_by_title(excel)

		#je me positionne dans le 1er onglet de mon fichier spreadsheet drive (excel drive)
		return onglet1 = file.worksheets[0]
	end


end
####################################################################################
####################################################################################
####################################################################################
#classe de fonctions concernant envoi gmail
class Sendmail

	#penser a activer le parametre autoriser application moins securise de gmail:
	# https://myaccount.google.com/lesssecureapps?pli=1

	#login sur compte gmail, tjs penser à faire un logout enfin de programme
	def login_gmail(gmail)
		load "secret.rb"
		usr = Username
		pwd = Password
		@gmail ||= Gmail.connect!(usr, pwd)
	end

	#fonction qui envoie un email depuis une session gmail en fct d'un spreadsheet drive avec nom en col A et email en col B
	def send_email_to_line( _session_gmail,_nom,_email)
		
		_session_gmail do |gmail|
			#gmail.logged_in?
			#on essaie
			gmail.deliver do
				to  _email   #"aliceulbert@gmail.com"

				subject "Hello #{_nom} : having fun in Puerto Rico!"

				text_part do
					body "Text of plaintext message."
				end

				html_part do					
					content_type 'text/html; charset=UTF-8'
					body "<p>Text of <em>html</em> message.</p>"
				end
				#add_file "/path/to/some_image.jpg"
			end

		end		
	end

end



####################################################################################
####################################################################################
####################################################################################

#execution du programme
page_url = "http://annuaire-des-mairies.com/creuse.html"

scrap23 = Scraping.new(page_url)

#affichage des url des mairies du dpt
url_list = scrap23.get_all_the_urls_of_department_townhalls(page_url)

#recup des noms et emails des mairies
townhall_list = scrap23.get_email_name(page_url)


#####################################
drive23 = Drive.new()
# on se log sur drive, et on recupere le sheet
session_drive = drive23.login_drive(nil)

#on remplit le fichier excel sheet du drive par les emails et noms de mairie
excel = "townhall_file"
excel = drive23.get_the_name_and_email_and_put_it_in_spreadsheet(session_drive,excel, townhall_list)



#####################################
binding.pry

gmail23 = Sendmail.new()

#on se logg sur gmail
session_gmail = gmail23.login_gmail(nil)

#on fait des tests
excel = "test"
onglet_excel = drive23.get_spreadsheet(session_drive, excel)

gmail23.send_email_to_line(onglet_excel, session_gmail)




#on va pouvoir boucler ainsui :

(2..onglet_excel.num_rows).each do |row|
	nom = onglet_excel[row,1]
	email = onglet_excel[row,2]
	gmail23.send_email_to_line(session_gmail,nom,email)
end

#penser à se deconnecter de gmail
#gmail.logout