class HomesController < ApplicationController
 
  def index
    @tweets = TwitterApi.response('whyistayed')
  end
end 

