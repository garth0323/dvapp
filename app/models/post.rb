class Post < ActiveRecord::Base
  belongs_to :page

  def self.upload_from_twitter(i, page)
    Post.create(
      profile_image_url: i["profile_image_url"],
      screen_name: i["screen_name"],
      name: i["name"],
      image_url: i["image_url"],
      text: i["text"],
      created: i["created"],
      social_id: i["social_id"],
      social_type: i["type"],
      page_id: page
      )
  end

end