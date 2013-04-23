class BiblioCommonsTitleContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :biblio_commons_title_content_item

  attr_accessible :tweet,
                  :biblio_commons_title_content_item

  validates :tweet,
            :biblio_commons_title_content_item,
            :presence => true

  content_match :content_id    => :title_id,
                :content_class => :biblio_commons_title_content_item

  def self.content_id_finder(url)
    BiblioCommons::Title.id_from_url(url)
  end
end
