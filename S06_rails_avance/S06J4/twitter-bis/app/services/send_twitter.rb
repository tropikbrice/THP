require "twitter"

class SendTwitter

	def initialize(tweet_string)
		@tweet_string = tweet_string
		log_in_to_twitter
		send_tweet
	end

	def log_in_to_twitter
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = Figaro.env.cons_key # "YOUR_CONSUMER_KEY"
			config.consumer_secret     = Figaro.env.cons_secret #{}"YOUR_CONSUMER_SECRET"
			config.access_token        = Figaro.env.acc_token #{}"YOUR_ACCESS_TOKEN"
			config.access_token_secret = Figaro.env.acc_token_secret #{}"YOUR_ACCESS_SECRET"
		end
	end

	def send_tweet
		@client.update( @tweet_string )
	end

end

