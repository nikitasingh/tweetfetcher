class TweetsController < ApplicationController
	before_filter :set_twitter_config
  def index
  	tweets = @client.user_timeline("TCS_News").take(500)
  	puts tweets.length
  	@tweets_1 = tweets[0..5]
  	@tweets_2 = tweets[6..10]
  	@tweets_3 = tweets[11..15]
  	@tweets_4 = tweets[16..20]
  end

  def set_twitter_config
	@client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = "0EjV9pC0SzaNThnUUneikFnq6"
	  config.consumer_secret     = "2YVAGVJGs5ikOXeMnyVIjF35AmjC4E2cdOEBtkkGM2DebN6fzp"
	  config.access_token        = "616382835-WbT02Ttvcmn24GTvgXbEcSFV5shSWFc5eHyCmCqZ"
	  config.access_token_secret = "Pw0os2QQFtRfr0JbYhG7MODwpKEMtrGvzWzbFjdQV2pKK"
	end
  end
end
