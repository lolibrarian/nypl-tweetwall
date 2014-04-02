require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  fixtures :blog_content_items,
           :blog_content_matches,
           :tweets
  def setup
    @content_item = blog_content_items(:new_york_times)
  end

  def test_overflow_all
    expected_retweets_all = [
      tweets(:tweet_7566),
      tweets(:tweet_7559),
      tweets(:tweet_7537),
      tweets(:tweet_7538),
      tweets(:tweet_7528),
      tweets(:tweet_7524)
    ]
    assert_equal expected_retweets_all,
                 @content_item.tweets.overflow(0)
  end

  def test_overflow_limit_1
    expected_retweets_limit_1 = [
      tweets(:tweet_7559),
      tweets(:tweet_7537),
      tweets(:tweet_7538),
      tweets(:tweet_7528),
      tweets(:tweet_7524)
    ]
    assert_equal expected_retweets_limit_1,
                 @content_item.tweets.overflow(1)
  end

  def test_overflow_limit_4
    expected_retweets_limit_4 = [
      tweets(:tweet_7528),
      tweets(:tweet_7524)
    ]
    assert_equal expected_retweets_limit_4,
                 @content_item.tweets.overflow(4)
  end

  def test_overflow_limit_6
    assert_empty @content_item.tweets.overflow(6)
  end
end
