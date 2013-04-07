class DigitalGalleryContentMatch < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :digital_gallery_content_item

  attr_accessible :tweet,
                  :digital_gallery_content_item

  validates :tweet,
            :digital_gallery_content_item,
            :presence => true

  # Iterates through the TweetUrls associated with the given Tweet instance,
  # looking for image IDs. If a image ID is found, the content item is either
  # then found or created. Finally, the match is made.
  def self.find_or_create_content_items(tweet)
    tweet.tweet_urls.each do |tweet_url|
      url = tweet_url.expanded_url
      image_id = self.image_id_from_url(url)
      next unless image_id

      digital_gallery_content_item = DigitalGalleryContentItem.find_or_create(image_id, url)
      next unless digital_gallery_content_item

      find_or_create_by_tweet_id_and_digital_gallery_content_item_id(tweet.id, digital_gallery_content_item.id)
    end
  end

  # Returns the image ID from a NYPL digital gallery URL, if found.
  def self.image_id_from_url(url)
    uri = URI(url)
    return unless uri.host == "digitalgallery.nypl.org"
    return unless uri.path == "/nypldigital/dgkeysearchdetail.cfm"

    params = Hash[*URI.decode_www_form(uri.query).flatten]

    params["imageID"]
  end
end
