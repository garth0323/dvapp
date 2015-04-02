class TweetsController < ApplicationController

  def new
    if user_signed_in?
      @tweet = current_user.tweets.new
    else
      @tweet = Tweet.new
    end
  end

  def create
    tag = Tweet.pound_sign(params[:tweet][:hashtag])
    if user_signed_in?
      @hashtag = current_user.tweets.create(hashtag: tag)
    else
      @hashtag = Tweet.create(hashtag: tag)
    end
    redirect_to tweets_path
  end

  def index
    start = TwitterApi.new
    @hashtag = Tweet.last.hashtag
    hash_response = start.response(@hashtag)
    @next_url = hash_response["next_url"]
    @tweets = hash_response["data"]
    @hashtags = Tweet.all
    if user_signed_in?
      @hashtags = current_user.tweets.all
    else
      @hashtags = Tweet.all
    end
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

