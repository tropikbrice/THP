require 'rubygems'
require 'nokogiri' 
require 'open-uri'
require "google_drive"
require "pry"
require 'gmail'


#classe de fonctions concernant google drive
class Drive

		#enregistrement dans un spreadsheet
	def login_drive(session)
		@session ||= GoogleDrive::Session.from_config("client_secret.json")
	end

	#fonction qui recupere juste le 1er ongler d un spreadsheet (pour pouvoir faire test)
	def get_spreadsheet(session, excel)
		#on recupere le fichier de notre drive
		file = session.spreadsheet_by_title(excel)

		#je me positionne dans le 1er onglet de mon fichier spreadsheet drive (excel drive)
		return onglet1 = file.worksheets[0]
	end


end




class Sendmail

	#login sur compte gmail, tjs penser à faire un logout enfin de programme
	def login_gmail(gmail)
		load "secret.rb"
		usr = Username
		pwd = Password
		@gmail ||= Gmail.connect(usr, pwd)
	end

	#fonction qui envoie un email depuis une session gmail en fct d'un spreadsheet drive avec nom en col A et email en col B
	def send_email_to_line(excel)

		#load "secret.rb"
		usr = "hackasensei@gmail.com"
		pwd = "Gmail972"
		
		Gmail.connect!(usr, pwd) do |gmail|
			puts gmail.logged_in?
			#on essaie
			gmail.deliver do
				to "aliceulbert@gmail.com"

				subject "Having fun in Puerto Rico!"

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

#####################################


gmail23 = Sendmail.new()

#on se logg sur gmail
#session_gmail = gmail23.login_gmail(nil)

#on fait des tests
excel = "test"
drive23 = Drive.new()
session_drive = drive23.login_drive(nil)
onglet_excel = drive23.get_spreadsheet(session_drive, excel)

gmail23.send_email_to_line(onglet_excel)
#binding.pry
#penser à se deconnecter de gmail
#gmail.logout