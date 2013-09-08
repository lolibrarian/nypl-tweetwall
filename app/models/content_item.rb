# A delegator to all content item classes.
class ContentItem
  # Returns all known content item classes.
  def self.classes
    [
      BlogContentItem,
      BiblioCommonsTitleContentItem,
      DigitalGalleryContentItem,
      BiblioCommonsListContentItem,
      DigitalCollectionsContentItem,
      ProgramContentItem,
      ExhibitionContentItem
    ]
  end

  # Returns all records from each of the given content item classes, including
  # (and sorted by) their associated Tweets.
  def self.all_including_and_sorted_by_tweets(classes)
    content_items = Array(classes).map do |klass|
      klass.includes(:tweets).order("tweets.tweet_created_at DESC").includes(:thumbnail)
    end.flatten
    exclude_without_tweets!(content_items)
    sort_by_first_tweet!(content_items)
  end

  # Excludes content items without any associated Tweets.
  def self.exclude_without_tweets!(content_items)
    content_items.select! { |content_item| content_item.tweets.any? }
  end

  # Sorts content items by their first Tweet.
  def self.sort_by_first_tweet!(content_items)
    content_items.sort_by! { |content_item| -1 * content_item.tweets.first.tweet_created_at.to_i }
  end

  # Deletes all expired content items.
  def self.delete_expired
    classes.each do |klass|
      klass.expired.destroy_all
    end
  end
end
