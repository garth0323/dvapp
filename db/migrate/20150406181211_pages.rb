class Pages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :hashtag
      t.text :description
      t.integer :user_id
      t.string :subdomain
      t.string :header
      
      t.timestamps
    end
  end
end
