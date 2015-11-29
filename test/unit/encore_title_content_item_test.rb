require 'test_helper'

class EncoreTitleContentItemTest < ActiveSupport::TestCase
  def setup
    @content_item = EncoreTitleContentItem.new
  end

  def test_fetch_metadata_title
    @content_item.stub(:encore, encore_stub) do
      assert_nil @content_item.title
      @content_item.fetch_metadata
      assert_equal encore_stub.title, @content_item.title
    end
  end

  def test_fetch_metadata_thumbnail
    without_fetching_remote_images do
      @content_item.stub(:encore, encore_stub) do
        assert_nil @content_item.thumbnail
        @content_item.fetch_metadata
        assert_equal encore_stub.thumbnail_url, @content_item.thumbnail.url
      end
    end
  end

  def test_fetch_metadata_format
    @content_item.stub(:encore, encore_stub) do
      assert_nil @content_item.format
      @content_item.fetch_metadata
      assert_equal encore_stub.format, @content_item.format
    end
  end

  def test_url
    @content_item.stub(:encore, encore_stub) do
      assert_equal encore_stub.url, @content_item.url
    end
  end

  def test_glyphicon_default
    assert_equal 'book-open', @content_item.glyphicon
  end

  def test_glyphicon_ebook
    @content_item.format = 'E-BOOK'
    assert_equal 'ipad', @content_item.glyphicon
  end

  def test_glyphicon_dvd
    @content_item.format = 'DVD'
    assert_equal 'film', @content_item.glyphicon
  end

  def test_glyphicon_music
    @content_item.format = 'MUSIC CD'
    assert_equal 'music', @content_item.glyphicon
  end

private

  def encore_stub
    OpenStruct.new(
      title: 'Why Read The Great Gatsby?',
      thumbnail_url: 'http://example.com/image.jpg',
      format: 'BLU-RAY',
      url: 'http://example.com/'
    )
  end
end
