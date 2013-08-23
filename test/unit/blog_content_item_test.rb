require 'test_helper'

class BlogContentItemTest < ActiveSupport::TestCase
  def setup
    @content_item = BlogContentItem.new
  end

  def test_fetch_metadata_title
    @content_item.stub(:blog, blog_mock) do
      assert_nil @content_item.title
      @content_item.fetch_metadata
      assert_equal blog_mock.title, @content_item.title
    end
  end

  def test_fetch_metadata_thumbnail
    without_fetching_remote_images do
      @content_item.stub(:blog, blog_mock) do
        assert_nil @content_item.thumbnail
        @content_item.fetch_metadata
        assert_equal blog_mock.thumbnail_url, @content_item.thumbnail.url
      end
    end
  end

  def test_url
    @content_item.stub(:blog, blog_mock) do
      assert_equal blog_mock.uri.to_s, @content_item.url
    end
  end

# Test mocks.

  def blog_mock
    OpenStruct.new(
      :title         => 'Why Read The Great Gatsby?',
      :thumbnail_url => 'http://example.com/image.jpg',
      :uri           => URI('http://example.com/')
    )
  end
end
