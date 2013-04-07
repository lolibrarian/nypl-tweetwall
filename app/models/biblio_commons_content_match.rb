class BiblioCommonsContentMatch < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :biblio_commons_content_item

  attr_accessible :tweet,
                  :biblio_commons_content_item

  validates :tweet,
            :biblio_commons_content_item,
            :presence => true

  # Iterates through the TweetUrls associated with the given Tweet instance,
  # looking for title IDs. If a title ID is found, the content item is either
  # then found or created. Finally, the match is made.
  def self.find_or_create_content_items(tweet)
    tweet.tweet_urls.each do |tweet_url|
      url = tweet_url.expanded_url
      title_id = self.title_id_from_url(url)
      next unless title_id

      biblio_commons_content_item = BiblioCommonsContentItem.find_or_create(title_id, url)
      next unless biblio_commons_content_item

      find_or_create_by_tweet_id_and_biblio_commons_content_item_id(tweet.id, biblio_commons_content_item.id)
    end
  end

  # Returns the title ID from a NYPL BiblioCommons URL, if found.
  def self.title_id_from_url(url)
    uri = URI(url)
    return unless uri.host == "nypl.bibliocommons.com"

    match = uri.path.scan(/\A\/item\/show\/(\d+)/).first
    return if match.nil?

    match.first
  end
end
