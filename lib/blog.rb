class Blog
  BASE_URI = URI.parse("http://www.nypl.org/blog/")

  # Extracts a NYPL Blogs ID from the given URL.
  def self.id_from_url(url)
    uri = URI(url)
    return unless uri.host == BASE_URI.host

    matches = uri.path.scan(/\A\/blog\/(.+)/).first
    return if matches.nil?

    matches.first
  end

  def initialize(id)
    @id = id
  end

  def uri
    BASE_URI + @id
  end

  def document
    @document ||= Nokogiri::HTML(open uri)
  end

  def title
    document.title.split("|").first.strip
  end

  def thumbnail_url
    document.xpath("//meta[@property='og:image']/@content").to_s
  end
end
