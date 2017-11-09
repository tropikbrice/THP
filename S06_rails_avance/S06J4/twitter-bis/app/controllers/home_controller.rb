class HomeController < ApplicationController

	#attr_accessor :post

	def index
		#@posts = Home.new
	end

	def bot_tweet
		SendTwitter.log_in_to_twitter()
		SendTwitter.new(params_tweet[:tweet]).send_tweet()
		render 'index'
	end

	private
		def params_tweet
			params.require(:params_tweet).permit(:tweet)
		end

end
