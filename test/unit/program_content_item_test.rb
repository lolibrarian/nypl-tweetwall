require 'test_helper'

class ProgramContentItemTest < ActiveSupport::TestCase
  def setup
    @content_item = ProgramContentItem.new
  end

  def test_fetch_metadata_title
    @content_item.stub(:program, program_stub) do
      assert_nil @content_item.title
      @content_item.fetch_metadata
      assert_equal program_stub.title, @content_item.title
    end
  end

  def test_fetch_metadata_thumbnail
    without_fetching_remote_images do
      @content_item.stub(:program, program_stub) do
        assert_nil @content_item.thumbnail
        @content_item.fetch_metadata
        assert_equal program_stub.thumbnail_url, @content_item.thumbnail.url
      end
    end
  end

  def test_url
    @content_item.stub(:program, program_stub) do
      assert_equal program_stub.uri.to_s, @content_item.url
    end
  end

  def test_glyphicon
    assert_equal 'calendar', @content_item.glyphicon
  end

  def test_thumbnail
    without_fetching_remote_images do
      thumbnail_url = program_stub.thumbnail_url
      @content_item.thumbnail = RemoteImage.new(:url => thumbnail_url)
      assert @content_item.thumbnail
      assert_equal thumbnail_url, @content_item.thumbnail.url
    end
  end

private

  def program_stub
    OpenStruct.new(
      :title         => 'Teen Advisory Group (TAG)',
      :thumbnail_url => 'http://example.com/image.jpg',
      :uri           => URI('http://example.com/')
    )
  end
end
