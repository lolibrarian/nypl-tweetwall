class ProgramContentMatch < ActiveRecord::Base
  include ContentMatch

  belongs_to :tweet
  belongs_to :program_content_item

  attr_accessible :tweet,
                  :program_content_item

  validates :tweet,
            :program_content_item,
            :presence => true

  content_match :content_id    => :program_id,
                :content_class => :program_content_item

  def self.content_id_finder(url)
    Program.id_from_url(url)
  end
end
