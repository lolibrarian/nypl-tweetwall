class RemoveRedundantIndices < ActiveRecord::Migration
  def change
    remove_index "biblio_commons_list_content_items", :name => "index_biblio_commons_list_content_items_on_list_id"
    remove_index "biblio_commons_list_content_matches", :name => "index_biblio_commons_list_content_matches_on_tweet_and_content"
    remove_index "biblio_commons_title_content_items", :name => "index_biblio_commons_title_content_items_on_title_id"
    remove_index "biblio_commons_title_content_matches", :name => "index_biblio_commons_title_content_matches_on_tweet_and_content"
    remove_index "blog_content_items", :name => "index_blog_content_items_on_blog_id"
    remove_index "blog_content_matches", :name => "index_blog_content_matches_on_tweet_id_and_blog_content_item_id"
    remove_index "digital_collections_content_items", :name => "index_digital_collections_content_items_on_mods_uuid"
    remove_index "digital_collections_content_matches", :name => "index_digital_collections_content_matches_on_tweet_and_content"
    remove_index "digital_gallery_content_items", :name => "index_digital_gallery_content_items_on_image_id"
    remove_index "digital_gallery_content_matches", :name => "index_digital_gallery_content_matches_on_tweet_and_content_item"
    remove_index "tweets", :name => "index_tweets_on_status_id"
  end
end
