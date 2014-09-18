class TwitterApi

  def self.response(tag)
    HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=%23#{tag}",
                { 
                  :headers => { 'Authorization' => 'Bearer AAAAAAAAAAAAAAAAAAAAACcdaQAAAAAA9Sx34TvF%2FvYRisl77b7ECdpLlV4%3DB3sKA0bm8ROQ7nsRG4RxIHhLE4EtKnf1RwIfRxTgY9iaFSwV2n' }
                 })
  end
end