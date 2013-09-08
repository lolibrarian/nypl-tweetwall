require 'test_helper'

class BlogContentItemTest < ActiveSupport::TestCase
  def setup
    @content_item = BlogContentItem.new
  end

  def test_fetch_metadata_title
    @content_item.stub(:blog, blog_stub) do
      assert_nil @content_item.title
      @content_item.fetch_metadata
      assert_equal blog_stub.title, @content_item.title
    end
  end

  def test_fetch_metadata_thumbnail
    without_fetching_remote_images do
      @content_item.stub(:blog, blog_stub) do
        assert_nil @content_item.thumbnail
        @content_item.fetch_metadata
        assert_equal blog_stub.thumbnail_url, @content_item.thumbnail.url
      end
    end
  end

  def test_url
    @content_item.stub(:blog, blog_stub) do
      assert_equal blog_stub.uri.to_s, @content_item.url
    end
  end

  def test_glyphicon
    assert_equal 'comment', @content_item.glyphicon
  end

private

  def blog_stub
    OpenStruct.new(
      :title         => 'Why Read The Great Gatsby?',
      :thumbnail_url => 'http://example.com/image.jpg',
      :uri           => URI('http://example.com/')
    )
  end
end
