class EncoreTitleContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :encore_title_content_item

  attr_accessible :tweet,
                  :encore_title_content_item

  validates :tweet,
            :encore_title_content_item,
            presence: true

  content_match content_id: :bib_id,
                content_class: :encore_title_content_item

  def self.content_id_finder(url)
    Encore::Title.id_from_url(url)
  end
end
