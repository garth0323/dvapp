module PagesHelper

  def reduce_json(i)
    if i["entities"]["media"].present?
      data = {
        profile_image_url: i["user"]["profile_image_url"],
        screen_name: i["user"]["screen_name"],
        name: i["user"]["name"],
        image_url: i["entities"]["media"][0]["media_url"],
        text: i["text"],
        created: i["created_at"],
        social_id: i["id_str"]
        }
    else
      data = {
        profile_image_url: i["user"]["profile_image_url"],
        screen_name: i["user"]["screen_name"],
        name: i["user"]["name"],
        text: i["text"],
        created: i["created_at"],
        social_id: i["id_str"]
        }
    end
  end
end