class TweetsController < ApplicationController

  def index
    start = TwitterApi.new
    hash_response = start.response('whyistayed')
    @next_url = hash_response["next_url"]
    @tweets = hash_response["data"]
    @hashtags = Tweet.all
  end

  def more
    hash_response = TwitterApi.next_response(params[:url])
    @next_url = hash_response["next_url"]
    @tweets = hash_response["data"]
  end
end 

