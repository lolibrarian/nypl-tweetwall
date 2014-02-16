require 'test_helper'

class AvContentItemTest < ActiveSupport::TestCase
  def setup
    @content_item = AvContentItem.new
  end

  def test_fetch_metadata_title
    @content_item.stub(:audio_video, av_stub) do
      assert_nil @content_item.title
      @content_item.fetch_metadata
      assert_equal av_stub.title, @content_item.title
    end
  end

  def test_fetch_metadata_thumbnail
    without_fetching_remote_images do
      @content_item.stub(:audio_video, av_stub) do
        assert_nil @content_item.thumbnail
        @content_item.fetch_metadata
        assert_equal av_stub.thumbnail_url, @content_item.thumbnail.url
      end
    end
  end

  def test_url
    @content_item.stub(:audio_video, av_stub) do
      assert_equal av_stub.uri.to_s, @content_item.url
    end
  end

private

  def av_stub
    OpenStruct.new(
      :title         => 'Tommy Turrentine, trumpet',
      :thumbnail_url => 'http://example.com/image.jpg',
      :uri           => URI('http://example.com/')
    )
  end
end
