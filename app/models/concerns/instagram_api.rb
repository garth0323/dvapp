class InstagramApi

  def initialize
    
  end
  
  def response(tag)
    json_data = HTTParty.get("https://api.instagram.com/v1/tags/#{tag}/media/recent?client_id=68f101725b6e45318b1e31d4aab991fc&count=10")
    results = Hash.new
    results["data"] = InstagramApi.pull_out_data(json_data["data"])
    results["next_url"] = InstagramApi.get_next_url(json_data)
    return results
  end

  def self.next_response(url)
    json_data = HTTParty.get(url)
    results = Hash.new
    results["data"] = InstagramApi.pull_out_data(json_data["data"])
    results["next_url"] = InstagramApi.get_next_url(json_data)
    return results
  end

  def self.pull_out_data(json_data)
    json = []
    json_data.each do |i|
      json << [
        profile_image_url: i["user"]["profile_picture"],
        screen_name: i["user"]["username"],
        name: i["user"]["full_name"],
        image_url: InstagramApi.image_or_video(i),
        text: i["caption"]["text"],
        created: InstagramApi.unix_time(i["created_time"]),
        social_id: i["user"]["id"],
        type: "instagram"
        ]
    end
    return json
  end

  def self.image_or_video(json)
    if json["videos"].present?
      json["videos"]["low_bandwith"]
    else
      json["images"]["low_resolution"]["url"]
    end
  end

  def self.unix_time(unix_time)
    Time.at(unix_time.to_i).asctime
  end

  def self.get_next_url(json_data)
    json_data["pagination"]["next_url"]
  end
end