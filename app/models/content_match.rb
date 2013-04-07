# A delegator to all content matching classes.
class ContentMatch
  # Returns all known content matching classes.
  def self.classes
    [BlogContentMatch]
  end

  # Updates1 matches between Tweets and content items.
  def self.update
    Tweet.find_in_batches do |batch|
      batch.each do |tweet|
        classes.each do |klass|
          klass.find_or_create_content_items(tweet)
        end
      end
    end
  end
end
