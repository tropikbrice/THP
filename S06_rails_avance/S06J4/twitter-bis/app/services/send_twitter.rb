require "twitter"

class SendTwitter

	def initialize(tweet_string)
		@tweet_string = tweet_string
	end

	def log_in_to_twitter
		@client_rest = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV["cons_key"] # "YOUR_CONSUMER_KEY"
			config.consumer_secret     = ENV["cons_secret"] #{}"YOUR_CONSUMER_SECRET"
			config.access_token        = ENV["acc_token"] #{}"YOUR_ACCESS_TOKEN"
			config.access_token_secret = ENV["acc_token_secret"] #{}"YOUR_ACCESS_SECRET"	
	end

	def send_tweet
		@client.update('@tweet_string')
	end

end

