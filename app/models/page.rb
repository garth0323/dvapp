class Page < ActiveRecord::Base
  # attr_accessible :description, :title, :header, :hashtag, :subdomain
  belongs_to :user
  has_many :posts
  mount_uploader :header, HeaderUploader

end