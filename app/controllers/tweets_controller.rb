class TweetsController < ApplicationController
  before_filter :set_twitter_config
  def index
  	@handle = params["handle"] ? params["handle"] : "TCS_News"
  	@tweets = @client.user_timeline(@handle, :count => 200)
  	@user_created_at = @tweets.first.user.created_at
  	@months = @tweets.map(&:created_at).map {|date| date.strftime("%B")} .uniq
  	current_month = params["month"] ? params["month"] : @tweets.first.created_at.strftime("%B")
  	@tweets = @tweets.select {|tweet| tweet.created_at.strftime("%B") == current_month}
  	respond_to do |format|
  	  format.html
      format.js
   end
  end

  def set_twitter_config
	@client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = "0EjV9pC0SzaNThnUUneikFnq6"
	  config.consumer_secret     = "2YVAGVJGs5ikOXeMnyVIjF35AmjC4E2cdOEBtkkGM2DebN6fzp"
	  config.access_token        = "616382835-WbT02Ttvcmn24GTvgXbEcSFV5shSWFc5eHyCmCqZ"
	  config.access_token_secret = "Pw0os2QQFtRfr0JbYhG7MODwpKEMtrGvzWzbFjdQV2pKK"
	end
	@handles = YAML.load_file("config/locales/handles.yml")
  end
end
