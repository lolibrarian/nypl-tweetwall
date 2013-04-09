class TweetwallController < ApplicationController
  caches_action :all,
                :blogs,
                :images,
                :books

  def all
    tweetwall(ContentItem)
  end

  def blogs
    tweetwall(BlogContentItem)
  end

  def images
    tweetwall(DigitalGalleryContentItem)
  end

  def books
    tweetwall(BiblioCommonsContentItem)
  end

  def tweetwall(klass)
    @content_items = klass.all.shuffle
    render :tweetwall
  end
end
