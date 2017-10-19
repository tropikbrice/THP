# comment passer en parametre la session de connexion à gmail
# ex :
require "gmail"

load "secret.rb"
usr = Username
pwd = Password

session_gmail = Gmail.connect!(usr, pwd)

def methode (session_gmail,usr,pwd)
	#Gmail.connect!(usr, pwd) do |gmail|
	session_gmail do |gmail|
		puts gmail.logged_in?
	end
end

methode(session_gmail,usr,pwd)

##############################
erreur :
 ruby ztest.rb 
ztest.rb:13:in `methode': undefined method `session_gmail' for main:Object (NoMethodError)
	from ztest.rb:18:in `<main>'
