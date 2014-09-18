class TweetsController < ApplicationController

  def index
    garth = TwitterApi.new
    @tweets = garth.response('Orlando')
    binding.pry
  end

  def more
    @instagram_data = HashtagRequest.instagram_next_call(params[:url])
  end
end 

