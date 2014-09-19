class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string  "hashtag"
      t.timestamps
    end
  end
end
