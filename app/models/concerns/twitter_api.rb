class TwitterApi

  def initialize
    
  end
  
  def response(tag)
    json_data = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=%23#{tag}&count=100",
                { 
                  :headers => { 'Authorization' => 'Bearer AAAAAAAAAAAAAAAAAAAAACcdaQAAAAAA9Sx34TvF%2FvYRisl77b7ECdpLlV4%3DB3sKA0bm8ROQ7nsRG4RxIHhLE4EtKnf1RwIfRxTgY9iaFSwV2n' }
                 })
    results = Hash.new
    results["data"] = TwitterApi.pull_out_tweets(json_data)
    results["next_url"] = TwitterApi.get_next_url(json_data)
    return results
  end

  def self.next_response(url)
    json_data = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json#{url}",
                { 
                  :headers => { 'Authorization' => 'Bearer AAAAAAAAAAAAAAAAAAAAACcdaQAAAAAA9Sx34TvF%2FvYRisl77b7ECdpLlV4%3DB3sKA0bm8ROQ7nsRG4RxIHhLE4EtKnf1RwIfRxTgY9iaFSwV2n' }
                 })
    results = Hash.new
    results["data"] = TwitterApi.pull_out_tweets(json_data)
    results["next_url"] = TwitterApi.get_next_url(json_data)
    return results
  end

  def self.pull_out_tweets(json_data)
    json_tweets = []
    json_data["statuses"].each do |i|
      json_tweets << i
    end
    return json_tweets
  end

  def self.get_next_url(json_data)
    json_data["search_metadata"]["refresh_url"]
  end
end