class HomesController < ApplicationController
  def index
    twitter_data = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=%23WhyIStayed",
                                { 
                                  :headers => { 'Authorization' => 'Bearer AAAAAAAAAAAAAAAAAAAAACcdaQAAAAAA9Sx34TvF%2FvYRisl77b7ECdpLlV4%3DB3sKA0bm8ROQ7nsRG4RxIHhLE4EtKnf1RwIfRxTgY9iaFSwV2n' }
                                 })
  end
end

# require 'base64'
# require 'httparty'
# require 'uri'
 
# class Twitter
#   include HTTParty
 
#   base_uri  'https://api.twitter.com'
#   format    :json
# end
 
# c_key = 'zMANaTjLVZDkdBeJK2dAPCkni'
# c_secret = '3htbSHjm5m9l0i4YgXLXNnhofsOBX2GZlVCHzVjAlQW2m3q7j3'
# c_key_secret = "#{c_key}:#{c_secret}"
# encoded_c_key_secret = Base64.strict_encode64(c_key_secret)
 
# headers = 
# {
#   'Authorization' => "Basic #{encoded_c_key_secret}", 
#   'Content-Type'  => "application/x-www-form-urlencoded;charset=UTF-8"
# }
# body = 'grant_type=client_credentials'
 
# response = Twitter.post('/oauth2/token', :body => body, :headers => headers)
