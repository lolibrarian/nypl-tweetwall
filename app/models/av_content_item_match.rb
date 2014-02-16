class AvContentItemMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :av_content_item

  attr_accessible :tweet,
                  :av_content_item

  validates :tweet,
            :av_content_item,
            :presence => true

  content_match :content_id    => :av_id,
                :content_class => :av_content_item

  def self.content_id_finder(url)
    AudioVideo.id_from_url(url)
  end
end
