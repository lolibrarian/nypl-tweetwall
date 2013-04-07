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

ActiveRecord::Schema.define(:version => 20130406221409) do

  create_table "blog_content_items", :force => true do |t|
    t.string   "url",           :null => false
    t.string   "title",         :null => false
    t.string   "thumbnail_url", :null => false
    t.string   "blog_id",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "blog_content_items", ["blog_id"], :name => "index_blog_content_items_on_blog_id"
  add_index "blog_content_items", ["blog_id"], :name => "unique_blog_id", :unique => true

  create_table "blog_content_matches", :force => true do |t|
    t.integer "tweet_id",             :null => false
    t.integer "blog_content_item_id", :null => false
  end

  add_index "blog_content_matches", ["tweet_id", "blog_content_item_id"], :name => "index_blog_content_matches_on_tweet_id_and_blog_content_item_id"
  add_index "blog_content_matches", ["tweet_id", "blog_content_item_id"], :name => "unique_blog_content_match", :unique => true

  create_table "tweet_urls", :force => true do |t|
    t.string   "original_url", :null => false
    t.string   "expanded_url", :null => false
    t.integer  "tweet_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "tweet_urls", ["tweet_id"], :name => "index_tweet_urls_on_tweet_id"

  create_table "tweets", :force => true do |t|
    t.string   "text",                           :null => false
    t.string   "user_name",                      :null => false
    t.string   "screen_name",                    :null => false
    t.string   "profile_image_url",              :null => false
    t.integer  "status_id",         :limit => 8, :null => false
    t.datetime "tweet_created_at",               :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "tweets", ["status_id"], :name => "index_tweets_on_status_id"
  add_index "tweets", ["status_id"], :name => "unique_status_id", :unique => true

end
