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
	def get_the_email_of_a_townhall_from_its_webpage(page_url)
		page = Nokogiri::HTML(open(page_url))

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
	def get_all_the_urls_of_department_townhalls(page_url)
		page = Nokogiri::HTML(open(page_url))

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
	def get_email_name(page_url)

		townhall_list = []
		get_all_the_urls_of_department_townhalls(page_url).each do |x|
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


	# #enregistrement dans un spreadsheet
	# def login_drive(session)
	# 	@session ||= GoogleDrive::Session.from_config("client_secret.json")
	# end

	# # #tab est un tableau car la fonction de scrapp retourne un tableau de hashs
	# #tab= get_email_hash()
	# def get_the_name_and_email_and_put_it_in_spreadsheet(fichier_mairie, tab)
	# 	#je me positionne dans le 1er onglet de mon fichier spreadsheet drive (excel drive)
	# 	onglet1 = fichier_mairie.worksheets[0]

	# 	# on demarre
	# 	# i à 2 car la 1ere ligne est la ligne qui contient les noms de colonne , i va de 2 à taille du tableau de hash soit 185+2=187
	# 	i=2
	# 	#binding.pry
	# 	tab.each do |element_du_tab_est_hash|
	# 		onglet1[i,1] = element_du_tab_est_hash[:name]

	# 		onglet1[i,2] = element_du_tab_est_hash[:email]

	# 		#incrementation des lignes "i" en dehors des boucles d'insertion des valeurs
	# 		i += 1
	# 	end

	# 	onglet1.save
	# end

end

#execution du programme
page_url = "http://annuaire-des-mairies.com/creuse.html"

scrap23 = Scraping.new(page_url)

binding.pry

townhall_list = scrap23.get_the_email_of_a_townhall_from_its_webpage(page_url)

