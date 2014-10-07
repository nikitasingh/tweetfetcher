class TweetsController < ApplicationController
  before_filter :set_twitter_config
  def index
    @handle = params["handle"] ? params["handle"] : "TCS_News"
    @handle = params["current_handle"] if params["current_handle"]
    @last_id = !params["handle"].nil? ? nil : params["last_id"]
  	@tweets = @handles["feeds"].include?(@handle)? get_feeds : get_tweets(params)
    @dates = @tweets.map(&:created_at).map {|date| date.strftime("%d-%b-%Y")} .uniq

  	respond_to do |format|
  	  format.html
      format.js
   end
  end

  def get_tweets(params)
    params["last_id"].nil? ? @client.user_timeline(@handle, :count => 20) : @client.user_timeline(@handle, :count => 10, :max_id => @last_id)[1..-1]
  end

  def get_feeds

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
