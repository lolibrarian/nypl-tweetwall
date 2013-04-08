# A delegator (and a mix-in) for all content matching classes.
module ContentMatch
  # Returns all known content matching classes.
  def self.classes
    [BlogContentMatch, BiblioCommonsContentMatch, DigitalGalleryContentMatch]
  end

  # Updates matches between Tweets and content items.
  def self.update
    Tweet.find_in_batches do |batch|
      batch.each do |tweet|
        classes.each do |klass|
          klass.find_or_create_content_items(tweet)
        end
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # For use within a Rails model. Defines a relationship between the
    # content_id and a content class for creating items, both given as symbols.
    def content_match(args)
      @content_id = args[:content_id]
      @content_class = args[:content_class]
    end

    # Returns a Ruby class for the content class name defined.
    def content_class
      raise ArgumentError if @content_class.nil?

      @content_class.to_s.camelize.constantize
    end

    # Creates the match record between the given Tweet and content item instances.
    def create_match(tweet, content_item)
      self.send("find_or_create_by_tweet_id_and_#{@content_class}_id", tweet.id, content_item.id)
    end

    def create_content_item(content_id, url)
      content_class.send("find_or_create_by_#{@content_id}", content_id, :url => url)
    end

    def content_id_finder(url)
      raise
    end

    # This function finds or creates content items, by:
    #
    #   1. Iterating through the TweetUrls associated with the given Tweet
    #   instance, looking for IDs with the content_id_finder method.
    #
    #   2. If an ID is found, the content item is either found or created with
    #   the content_class.
    #
    #   3. Finally, the match is made between the Tweet and content item.
    #
    def find_or_create_content_items(tweet)
      tweet.tweet_urls.each do |tweet_url|
        url = tweet_url.expanded_url
        content_id = content_id_finder(url)
        next unless content_id

        content_item = create_content_item(content_id, url)
        next unless content_item

        create_match(tweet, content_item)
      end
    end
  end
end
