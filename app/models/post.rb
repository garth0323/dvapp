class Post < ActiveRecord::Base
  belongs_to :page

  def self.upload_from_twitter(i, page)
    binding.pry
    Post.create(
      profile_image_url: i["profile_image_url"],
      screen_name: i["screen_name"],
      name: i["name"],
      image_url: i["image_url"],
      text: i["text"],
      created: i["created_at"],
      social_id: i["social_id"],
      page_id: page
      )
  end

end