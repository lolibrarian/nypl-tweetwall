class TweetwallController < ApplicationController
  caches_action :all,
                :blogs,
                :images,
                :books

  def all
    tweetwall(ContentItem.classes)
  end

  def blogs
    tweetwall(BlogContentItem)
  end

  def images
    tweetwall(DigitalGalleryContentItem)
  end

  def books
    tweetwall([BiblioCommonsTitleContentItem, BiblioCommonsListContentItem])
  end

private

  def tweetwall(classes)
    @content_items = ContentItem.all_including_and_sorted_by_tweets(classes)
    render :tweetwall
  end
end
