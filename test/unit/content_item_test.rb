require 'test_helper'

class ContentItemTest < ActiveSupport::TestCase
  fixtures :blog_content_items,
           :blog_content_matches,
           :tweets,
           :tweet_urls

  def test_all_including_and_sorted_by_tweets
    expected_content_items = [
      blog_content_items(:wonder_years),
      blog_content_items(:new_york_times),
      blog_content_items(:road_trip)
    ]
    actual_content_items = ContentItem.all_including_and_sorted_by_tweets(BlogContentItem)
    assert_equal expected_content_items, actual_content_items
  end

  def test_exclude_without_tweets!
    expected_content_items = [
      blog_content_items(:road_trip),
      blog_content_items(:wonder_years)
    ]
    processed_content_items = [
      blog_content_items(:musical),
      blog_content_items(:road_trip),
      blog_content_items(:wonder_years)
    ]
    ContentItem.exclude_without_tweets!(processed_content_items)
    assert_equal expected_content_items, processed_content_items
  end

  def test_sort_by_first_tweet!
    expected_content_items = [
      blog_content_items(:new_york_times),
      blog_content_items(:wonder_years),
      blog_content_items(:road_trip)
    ]
    processed_content_items = [
      blog_content_items(:wonder_years),
      blog_content_items(:new_york_times),
      blog_content_items(:road_trip)
    ]
    ContentItem.sort_by_first_tweet!(processed_content_items)
    assert_equal expected_content_items, processed_content_items
  end

  def test_delete_expired
    # These content items ought *not* to expire.
    expected_content_items = [
      blog_content_items(:wonder_years),
      blog_content_items(:road_trip),
    ]
    blog_content_items(:wonder_years).update_attribute(:created_at, 5.minutes.ago)
    blog_content_items(:road_trip).update_attribute(:created_at, 30.minutes.ago)

    # These content items *ought* to expire.
    blog_content_items(:new_york_times).update_attribute(:created_at, 2.hours.ago)
    blog_content_items(:musical).update_attribute(:created_at, 1.week.ago)

    ContentItem.delete_expired
    assert_equal expected_content_items, BlogContentItem.all
  end
end
