class TweetwallController < ApplicationController
  caches_page :index

  def index
    @content_items = ContentItem.all.shuffle
  end
end
