class CombinedResponse

  def initialize

  end

  def self.return_hashtag_json(hashtag)
    twitter_response = TwitterApi.new.response(hashtag)
    instagram_response = InstagramApi.new.response(hashtag)
    results = Hash.new
    results["next_url"] = CombinedResponse.next_urls(twitter_response["next_url"], instagram_response["next_url"])
    results["posts"] = CombinedResponse.combine_posts(twitter_response["data"], instagram_response["data"])
    return results
  end

  def self.next_response(urls)
    twitter_response = TwitterApi.next_response(urls["twitter_next_url"])
    instagram_response = InstagramApi.next_response(urls["instagram_next_url"])
    results = Hash.new
    results["next_url"] = CombinedResponse.next_urls(twitter_response["next_url"], instagram_response["next_url"])
    results["posts"] = CombinedResponse.combine_posts(twitter_response["data"], instagram_response["data"])
    return results
  end

  def self.combine_posts(tweets, instagrams)
    posts = (tweets << instagrams).flatten!
  end


  def self.next_urls(twitter, instagram)
    url = Hash.new
    url["twitter_next_url"] = twitter
    url["instagram_next_url"] = instagram
    return url
  end

end