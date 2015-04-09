sclass CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string  "hashtag"
      t.integer "user_id"
      t.timestamps
    end
  end
end
