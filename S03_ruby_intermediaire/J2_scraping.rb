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
require_relative "/home/brice/Documents/THP/S02J04/rte_mairie.rb"


class scraping
	#class de fonctions permettant de realiser du scraping des mairies de france
	#via l'url

	attr_accessor :page_url

	#récupère l'adresse email à partir de l'url d'une mairie
	#pour plus de details sur la construction des fonctions :
	#cf fichier rte_mairie.rb
	def get_the_email_of_a_townhall_from_its_webpage(@page_url)
		page = Nokogiri::HTML(open(@page_url))

		#recuperation de l'email en "parsant" le html via XPATH
		email = page.xpath('//td[@class="style27"]/p[@class="Style22"]')

		#afin de gerer les index des adresses vides on fait un ||= "" pour le retour de find_index
		index_email = email2.text.split("\u00A0").find_index{|x| x.include?("@")}
		index_email ||= 0

		email3= email2.text.split("\u00A0")[index_email]
		return email3
	end

	#récupère toutes les url de villes du departement
	#en retournant un hash contenant url pour chaque ville
	def get_all_the_urls_of_department_townhalls(@page_url)
		page = Nokogiri::HTML(open(@page_url))

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
	def get_email_name(@page_url)

		townhall_list = []
		get_all_the_urls_of_val_doise_townhalls(@page_url).each do |x|
			#il y avait une erreur de mail non renseigne , vu grace aux instructions ci dessous
			#donc on doit traiter les emails vides : ok fait ds la def de la fonction cidessus
			# puts "--------"
			#puts x[:url]

			email_ville=get_the_email_of_a_townhal_from_its_webpage( x[:url])
			#puts x[:url]

			townhall_list << { x[:name] => email_ville }
		end
		return townhall_list
	end




end