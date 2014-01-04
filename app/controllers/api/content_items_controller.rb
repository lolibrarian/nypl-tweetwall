module Api
  class ContentItemsController < ApplicationController
    caches_action :index

    def index
      classes = classes_for_category(params[:category])
      content_items = ContentItem.all_including_and_sorted_by_tweets(classes)

      respond_to do |format|
        format.json do
          render :json => content_items.to_json(
            :only => [:title],
            :methods => [:url, :category, :glyphicon],
            :include => {
              :tweets => {
                :only => [
                  :id, :profile_image_url, :retweeted_status_id, :screen_name,
                  :status_id, :text, :tweet_created_at, :user_name
                ],
                :methods => [:url, :profile_url]
              },
              :thumbnail => {
                :only => [:id, :url],
                :methods => [:tweetwall_width, :tweetwall_height]
              }
            },
          )
        end
      end
    end

  private

    def classes_for_category(category)
      case category
      when 'all'    then ContentItem.classes
      when 'blogs'  then BlogContentItem
      when 'images' then [DigitalGalleryContentItem, DigitalCollectionsContentItem]
      when 'books'  then BiblioCommonsTitleContentItem
      when 'lists'  then BiblioCommonsListContentItem
      when 'events' then [ProgramContentItem, ExhibitionContentItem]
      end
    end
  end
end
