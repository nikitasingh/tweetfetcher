class TweetsController < ApplicationController
  before_filter :set_twitter_config
  # encoding: utf-8
  require 'simple-rss'
  def index
    @handle = params["handle"] ? params["handle"] : "TCS_News"
    @handle = params["current_handle"] if params["current_handle"]
    @last_id = !params["handle"].nil? ? nil : params["last_id"]
  	@result = @handles["feeds"].include?(@handle)? get_feeds(params) : get_tweets(params)
    @last_tweet_date = params["last_tweet_date"] if params["last_tweet_date"]
  	respond_to do |format|
  	  format.html
      format.js
   end
  end

  def get_tweets(params)
    tweets = params["last_id"].nil? ? @client.user_timeline(@handle, :count => 200) : @client.user_timeline(@handle, :count => 200, :max_id => @last_id)[1..-1]
    @dates = tweets.map(&:created_at).map {|date| date.strftime("%d-%b-%Y")} .uniq
    tweets
  end

  def get_feeds(params)
    rss = SimpleRSS.parse open(@handles["feeds"][params["handle"]])
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
