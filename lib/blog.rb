class Blog
  def initialize(url)
    @url = url
  end

  def document
    @document ||= Nokogiri::HTML(open @url)
  end

  def title
    document.title.split("|").first.strip
  end

  def thumbnail_url
    document.xpath("//meta[@property='og:image']/@content").to_s
  end
end

