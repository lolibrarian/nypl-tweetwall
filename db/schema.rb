# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140216165347) do

  create_table "av_content_item_matches", :force => true do |t|
    t.integer "tweet_id",           :null => false
    t.integer "av_content_item_id", :null => false
  end

  add_index "av_content_item_matches", ["tweet_id", "av_content_item_id"], :name => "unique_av_content_match", :unique => true

  create_table "av_content_items", :force => true do |t|
    t.string   "title",        :limit => 510, :null => false
    t.integer  "thumbnail_id",                :null => false
    t.string   "av_id",                       :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "av_content_items", ["av_id"], :name => "index_av_content_items_on_av_id", :unique => true

  create_table "biblio_commons_list_content_items", :force => true do |t|
    t.string   "title",        :limit => 510, :null => false
    t.integer  "list_id",      :limit => 8,   :null => false
    t.integer  "user_id",      :limit => 8,   :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "thumbnail_id"
  end

  add_index "biblio_commons_list_content_items", ["list_id"], :name => "unique_list_id", :unique => true

  create_table "biblio_commons_list_content_matches", :force => true do |t|
    t.integer "tweet_id",                            :null => false
    t.integer "biblio_commons_list_content_item_id", :null => false
  end

  add_index "biblio_commons_list_content_matches", ["tweet_id", "biblio_commons_list_content_item_id"], :name => "unique_biblio_commons_list_content_match", :unique => true

  create_table "biblio_commons_title_content_items", :force => true do |t|
    t.string   "title",        :limit => 510, :null => false
    t.integer  "title_id",     :limit => 8,   :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "thumbnail_id"
    t.string   "format",                      :null => false
  end

  add_index "biblio_commons_title_content_items", ["title_id"], :name => "unique_title_id", :unique => true

  create_table "biblio_commons_title_content_matches", :force => true do |t|
    t.integer "tweet_id",                             :null => false
    t.integer "biblio_commons_title_content_item_id", :null => false
  end

  add_index "biblio_commons_title_content_matches", ["tweet_id", "biblio_commons_title_content_item_id"], :name => "unique_biblio_commons_title_content_match", :unique => true

  create_table "blog_content_items", :force => true do |t|
    t.string   "title",        :limit => 510, :null => false
    t.string   "blog_id",                     :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "thumbnail_id"
  end

  add_index "blog_content_items", ["blog_id"], :name => "unique_blog_id", :unique => true

  create_table "blog_content_matches", :force => true do |t|
    t.integer "tweet_id",             :null => false
    t.integer "blog_content_item_id", :null => false
  end

  add_index "blog_content_matches", ["tweet_id", "blog_content_item_id"], :name => "unique_blog_content_match", :unique => true

  create_table "digital_collections_content_items", :force => true do |t|
    t.string   "title",        :limit => 510, :null => false
    t.integer  "thumbnail_id",                :null => false
    t.string   "mods_uuid",    :limit => 36,  :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "digital_collections_content_items", ["mods_uuid"], :name => "unique_mods_uuid", :unique => true

  create_table "digital_collections_content_matches", :force => true do |t|
    t.integer "tweet_id",                            :null => false
    t.integer "digital_collections_content_item_id", :null => false
  end

  add_index "digital_collections_content_matches", ["tweet_id", "digital_collections_content_item_id"], :name => "unique_digital_collections_content_match", :unique => true

  create_table "digital_gallery_content_items", :force => true do |t|
    t.string   "title",        :limit => 510, :null => false
    t.string   "image_id",                    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "thumbnail_id"
  end

  add_index "digital_gallery_content_items", ["image_id"], :name => "unique_image_id", :unique => true

  create_table "digital_gallery_content_matches", :force => true do |t|
    t.integer "tweet_id",                        :null => false
    t.integer "digital_gallery_content_item_id", :null => false
  end

  add_index "digital_gallery_content_matches", ["tweet_id", "digital_gallery_content_item_id"], :name => "unique_digital_gallery_content_match", :unique => true

  create_table "exhibition_content_items", :force => true do |t|
    t.string   "title",         :limit => 510, :null => false
    t.integer  "thumbnail_id",                 :null => false
    t.string   "exhibition_id",                :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "exhibition_content_items", ["exhibition_id"], :name => "index_exhibition_content_items_on_exhibition_id", :unique => true

  create_table "exhibition_content_matches", :force => true do |t|
    t.integer "tweet_id",                   :null => false
    t.integer "exhibition_content_item_id", :null => false
  end

  add_index "exhibition_content_matches", ["tweet_id", "exhibition_content_item_id"], :name => "unique_exhibition_content_match", :unique => true

  create_table "program_content_items", :force => true do |t|
    t.string   "title",        :limit => 510, :null => false
    t.integer  "thumbnail_id",                :null => false
    t.string   "program_id",                  :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "program_content_items", ["program_id"], :name => "index_program_content_items_on_program_id", :unique => true

  create_table "program_content_matches", :force => true do |t|
    t.integer "tweet_id",                :null => false
    t.integer "program_content_item_id", :null => false
  end

  add_index "program_content_matches", ["tweet_id", "program_content_item_id"], :name => "unique_program_content_match", :unique => true

  create_table "remote_images", :force => true do |t|
    t.string   "url",        :limit => 1020, :null => false
    t.integer  "width",                      :null => false
    t.integer  "height",                     :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "tweet_urls", :force => true do |t|
    t.string   "original_url", :limit => 1020, :null => false
    t.string   "expanded_url", :limit => 1020, :null => false
    t.integer  "tweet_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "tweet_urls", ["tweet_id"], :name => "index_tweet_urls_on_tweet_id"

  create_table "tweets", :force => true do |t|
    t.string   "text",                             :null => false
    t.string   "user_name",                        :null => false
    t.string   "screen_name",                      :null => false
    t.string   "profile_image_url",                :null => false
    t.integer  "status_id",           :limit => 8, :null => false
    t.datetime "tweet_created_at",                 :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "retweeted_status_id", :limit => 8
  end

  add_index "tweets", ["status_id"], :name => "unique_status_id", :unique => true

end
