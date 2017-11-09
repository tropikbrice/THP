class HomeController < ApplicationController

	#attr_accessor :post

	def index
		if params.key?(:tweet)
			SendTwitter.new params_tweet
			#render 'index'
		end
	end

	private
		def params_tweet
			params.require(:tweet)
		end

end