#!/usr/bin/env ruby

# realiser un jeu de ti point ti croix = morpion = tic tac toe

class BoardCase
	#TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
	attr_accessor :value , :case_nb

	def initialize(value="", case_nb)
		#TO DO doit régler sa valeur, ainsi que son numéro de case
		@value = value
		@case_nb = case_nb
	end

	def to_s(value)
		#TO DO : doit renvoyer la valeur au format string
		return value.to_s
	end
end
################################################################
################################################################
################################################################

class Board
	include Enumerable
	#TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases

	attr_accessor :board


	def initialize
		#TO DO :
		#Quand la classe s'initialize, elle doit créer 9 instances BoardCases
		#Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
		@board = Array.new(9)
		i=0
		@board.each do |cell|
			#puts cell
			#puts "#{i}"
			cell = BoardCase.new("",i)
			i+=1
		end
		#puts "init ok !"
		#partie validee
	end

	def display()
		#TO DO : afficher le plateau
		#affiche le tableau en fonction du parametre board
		#puts "board index is 0 to 8 "
		#puts " le 0 : #{@board[0]} "
		puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
		puts "-----------"
		puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
		puts "-----------"
		puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
	end

	def play(value,case_nb)
		#TO DO : une méthode qui change la BoardCase jouée en fonction de la valeur du joueur (X, ou O)
		return @board[case_nb]= value
	end

	def victory?
		#TO DO : qui gagne ?
	end

end
################################################################
################################################################
################################################################

class Player
	#TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?

	attr_accessor :name , :value
	attr_writer :status			#running , lose, win

	def initialize(name,value, status )
		#TO DO : doit régler son nom, sa valeur, son état de victoire
		#puts "type your name"
		#@name = gets.chomp.capitalize!
		@name = name.capitalize!
		@value = value
		@status = status
		puts "Hello, my name is #{@name} , my value is #{@value} , and #{@status}"
	end

end
################################################################
################################################################
################################################################

class Game
	attr_accessor :player1 , :player2
	def initialize
		#TO DO : créé 2 joueurs, créé un board
		@player1 = Player.new("brice", "X", "" )
		@player2 = Player.new("naula", "O", "" )
	end

	def go
		# TO DO : lance la partie
		board = Board.new
		board.display

		puts "entrer valeur"
		cell=gets.chomp
		cell=cell.to_i

		puts "fin"

		#puts @player1.value
		# puts cell

		board.play(@player1.value, cell)

		board.display

		puts "#{@player2.name} entrer valeur"
		cell=gets.chomp
		cell=cell.to_i

		board.play(@player2.value, cell)
		board.display

	end

	def turn
		#TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
	end

end
################################################################
################################################################
################################################################

Game.new.go