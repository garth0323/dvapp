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
      session_array(tag)
    end
    redirect_to tweets_path
  end

  def index
    start = TwitterApi.new
    if user_signed_in?
      @hashtags = current_user.tweets.all
      @hashtag = Tweet.last.hashtag
    else
      @hashtags = session[:tweet]
      @hashtag = session[:tweet].last
    end
    hash_response = start.response(@hashtag)
    @next_url = hash_response["next_url"]
    @tweets = hash_response["data"]
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

  def session_array(tag)
    if session[:tweet].present?
      return session[:tweet].push(tag)
    else
      session[:tweet] = Array.new
      return session[:tweet] = [tag]
    end
  end
end 

