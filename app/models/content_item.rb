# A delegator to all content item classes.
class ContentItem
  # Returns all known content item classes.
  def self.classes
    [BlogContentItem, BiblioCommonsContentItem, DigitalGalleryContentItem]
  end

  # Returns all records from all content item classes (and associated Tweets).
  def self.all
    classes.map { |klass| klass.includes(:tweets) }.flatten
  end

  # Deletes all expired content items.
  def self.delete_expired
    classes.each do |klass|
      klass.expired.destroy_all
    end
  end
end
