# Because it's powered by a CMS, pages on NYPL's web site share a number of
# common characteristics.
module NYPLContentType
  # If a piece of content does not have a thumbnail, it's automatically assigned
  # this image.
  DEFAULT_THUMBNAIL_URI = URI('http://www.nypl.org/sites/all/themes/nypl_new/images/nypl_logo_share.jpg')

  def initialize(id)
    @id = id
  end

  def uri
    self.class::BASE_URI + @id
  end

  def document
    @document ||= Nokogiri::HTML(open uri)
  end

  def title
    document.title.split('|').first.strip
  end

  def thumbnail_url
    document.xpath("//meta[@property='og:image']/@content").to_s
  end
end
