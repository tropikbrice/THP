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

	#récupère l'adresse email à partir de l'url d'une mairie
	# pour plus de details sur la construction des fonctions :
	#cf fichier rte_mairie.rb
	def get_the_email_of_a_townhal_from_its_webpage(page_url)
		page = Nokogiri::HTML(open(page_url))

		email2 = page.xpath('//td[@class="style27"]/p[@class="Style22"]')

		#afin de gerer les index des adresses vides on fait un ||= "" pour le retour de find_index
		index_email = email2.text.split("\u00A0").find_index{|x| x.include?("@")}
		index_email ||= 0

		email3= email2.text.split("\u00A0")[index_email ]

		return email3
	end




end