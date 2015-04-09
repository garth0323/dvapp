class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :profile_image_url
      t.string :screen_name
      t.string :name
      t.string :image_url
      t.string :text
      t.integer :page_id
      t.datetime :created
      t.string :social_id

      t.timestamps
    end
  end
end
