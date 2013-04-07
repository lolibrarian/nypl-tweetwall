class BiblioCommonsContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :biblio_commons_content_item

  attr_accessible :tweet,
                  :biblio_commons_content_item

  validates :tweet,
            :biblio_commons_content_item,
            :presence => true

  content_match :content_id_finder => :title_id_from_url,
                :content_class     => :biblio_commons_content_item

  # Returns the title ID from the given URL, if found.
  def self.title_id_from_url(url)
    uri = URI(url)
    return unless uri.host == BiblioCommons::NYPL_HOST

    matches = uri.path.scan(/\A\/item\/show\/(\d+)/).first
    return if matches.nil?

    matches.first
  end
end
