class TweetwallController < ApplicationController
  caches_action :index

  def index
    @content_items = ContentItem.all.shuffle
  end
end
