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
    # start = TwitterApi.new
    if user_signed_in?
      @hashtags = current_user.tweets.all
      @hashtag = Tweet.last.hashtag
    else
      @hashtags = session[:tweet]
      @hashtag = session[:tweet].last
    end
    response = CombinedResponse.return_hashtag_json(@hashtag)
    @next_url = response["next_url"]
    @posts = response["posts"]
  end

  def more
    response = CombinedResponse.next_response(params[:url])
    @next_url = response["next_url"]
    @posts = response["posts"]
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

