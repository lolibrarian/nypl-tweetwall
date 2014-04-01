require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  fixtures :blog_content_items,
           :blog_content_matches,
           :tweets
  def setup
    @content_item = blog_content_items(:new_york_times)
  end

  def test_overflow_retweets_all
    expected_retweets_all = [
      tweets(:tweet_7566),
      tweets(:tweet_7537),
      tweets(:tweet_7538)
    ]
    assert_equal expected_retweets_all,
                 @content_item.tweets.overflow_retweets(0)
  end

  def test_overflow_retweets_limit_1
    expected_retweets_limit_1 = [
      tweets(:tweet_7537),
      tweets(:tweet_7538)
    ]
    assert_equal expected_retweets_limit_1,
                 @content_item.tweets.overflow_retweets(1)
  end

  def test_overflow_retweets_limit_2
    expected_retweets_limit_2 = [
      tweets(:tweet_7538)
    ]
    assert_equal expected_retweets_limit_2,
                 @content_item.tweets.overflow_retweets(2)
  end

  def test_overflow_retweets_limit_3
    assert_empty @content_item.tweets.overflow_retweets(3)
  end
end
