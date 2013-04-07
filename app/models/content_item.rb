# A delegator to all content item classes.
class ContentItem
  # Returns all known content item classes.
  def self.classes
    [BlogContentItem]
  end

  # Returns all records from all content item classes.
  def self.all
    classes.map(&:all).flatten
  end

  # Expires all content items.
  def self.expire_all
    classes.each do |klass|
      klass.expired.destroy_all
    end
  end
end
