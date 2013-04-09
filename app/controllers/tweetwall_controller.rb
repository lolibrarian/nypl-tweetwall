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

private

  def tweetwall(klass)
    @content_items = klass.all
    exclude_without_tweets!(@content_items)
    order_by_most_recent_tweet!(@content_items)
    render :tweetwall
  end

  def exclude_without_tweets!(content_items)
    content_items.select! { |content_item| content_item.tweets.any? }
  end

  def order_by_most_recent_tweet!(content_items)
    content_items.sort_by! { |content_item| -1 * content_item.tweets.first.tweet_created_at.to_i }
  end
end
