class Tweet < ActiveRecord::Base
  include Expirable

  has_many :tweet_urls, :dependent => :destroy
  has_many :blog_content_matches, :dependent => :destroy
  has_many :blog_content_items, :through => :blog_content_matches
  has_many :biblio_commons_content_matches, :dependent => :destroy
  has_many :biblio_commons_content_items, :through => :biblio_commons_content_matches
  has_many :digital_gallery_content_matches, :dependent => :destroy
  has_many :digital_gallery_content_items, :through => :digital_gallery_content_matches

  attr_accessible :text,
                  :user_name,
                  :screen_name,
                  :profile_image_url,
                  :status_id,
                  :tweet_created_at

  validates :text,
            :user_name,
            :screen_name,
            :profile_image_url,
            :status_id,
            :tweet_created_at,
            :presence => true

  validate :unexpired?, :on => :create

  expires_in 3.days, :tweet_created_at

  def url
    "https://twitter.com/#{screen_name}/status/#{status_id}"
  end
end
