class TweetwallController < ApplicationController
  def index
    @content_items = BlogContentItem.all
  end
end
