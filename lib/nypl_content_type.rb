# Because it's powered by a CMS, pages on NYPL's web site share a number of
# common characteristics.
module NYPLContentType
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

  # Returns an element for the content in the document (ex. the blog post
  # itself, excluding navigation, sidebars, footer, etc.).
  def content
    document.css(self.class::CONTENT_SELECTOR)
  end

  # Returns an element for the first image in the content.
  def first_image_in_content
    @first_image_in_content ||= content.css('img').first
  end

  def thumbnail_url
    return unless first_image_in_content

    first_image_in_content['src']
  end
end
