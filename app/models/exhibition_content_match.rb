class ExhibitionContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :exhibition_content_item

  attr_accessible :tweet,
                  :exhibition_content_item

  validates :tweet,
            :exhibition_content_item,
            :presence => true

  content_match :content_id    => :exhibition_id,
                :content_class => :exhibition_content_item

  def self.content_id_finder(url)
    Exhibition.id_from_url(url)
  end
end
