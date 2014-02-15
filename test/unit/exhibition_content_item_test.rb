require 'test_helper'

class ExhibitionContentItemTest < ActiveSupport::TestCase
  def setup
    @content_item = ExhibitionContentItem.new
  end

  def test_fetch_metadata_title
    @content_item.stub(:exhibition, exhibition_stub) do
      assert_nil @content_item.title
      @content_item.fetch_metadata
      assert_equal exhibition_stub.title, @content_item.title
    end
  end

  def test_fetch_metadata_thumbnail
    without_fetching_remote_images do
      @content_item.stub(:exhibition, exhibition_stub) do
        assert_nil @content_item.thumbnail
        @content_item.fetch_metadata
        assert_equal exhibition_stub.thumbnail_url, @content_item.thumbnail.url
      end
    end
  end

  def test_url
    @content_item.stub(:exhibition, exhibition_stub) do
      assert_equal exhibition_stub.uri.to_s, @content_item.url
    end
  end

private

  def exhibition_stub
    OpenStruct.new(
      :title         => 'A Lighthouse in New York',
      :thumbnail_url => 'http://example.com/image.jpg',
      :uri           => URI('http://example.com/')
    )
  end
end
