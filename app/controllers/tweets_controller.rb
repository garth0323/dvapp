class TweetsController < ApplicationController

  def new
    @tweet = Tweet.new
  end

  def create
    # scrape off hashtag method needed
    @hashtag = Tweet.create(tweet_params)
    redirect_to tweets_path
  end

  def index
    start = TwitterApi.new
    @hashtag = Tweet.last.hashtag
    hash_response = start.response(@hashtag)
    @next_url = hash_response["next_url"]
    @tweets = hash_response["data"]
    @hashtags = Tweet.all
  end

  def more
    hash_response = TwitterApi.next_response(params[:url])
    @next_url = hash_response["next_url"]
    @tweets = hash_response["data"]
  end

  private

  def tweet_params
    params.require(:tweet).permit!
  end
end 

