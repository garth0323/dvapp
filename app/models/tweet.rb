class Tweet < ActiveRecord::Base

  def self.pound_sign(hashtag)
    if hashtag[0] != "#"
      hashtag.chomp
    else 
      hashtag[1...100]
    end
  end
end
