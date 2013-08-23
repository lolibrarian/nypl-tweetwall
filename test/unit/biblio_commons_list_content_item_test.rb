require 'test_helper'

class BiblioCommonsListContentItemTest < ActiveSupport::TestCase
  def setup
    @content_item = BiblioCommonsListContentItem.new
  end

  def test_fetch_metadata_user_id
    @content_item.stub(:biblio_commons, biblio_commons_mock) do
      assert_nil @content_item.user_id
      @content_item.fetch_metadata
      assert_equal biblio_commons_mock.user_id, @content_item.user_id
    end
  end

  def test_fetch_metadata_title
    @content_item.stub(:biblio_commons, biblio_commons_mock) do
      assert_nil @content_item.title
      @content_item.fetch_metadata
      assert_equal biblio_commons_mock.name, @content_item.title
    end
  end

  def test_fetch_metadata_thumbnail
    without_fetching_remote_images do
      @content_item.stub(:biblio_commons, biblio_commons_mock) do
        assert_nil @content_item.thumbnail
        @content_item.fetch_metadata
        assert_equal biblio_commons_mock.thumbnail_url, @content_item.thumbnail.url
      end
    end
  end

  def test_url
    @content_item.stub(:biblio_commons, biblio_commons_mock) do
      assert_equal biblio_commons_mock.url, @content_item.url
    end
  end

  def test_glyphicon
    assert_equal 'sort', @content_item.glyphicon
  end

# Test mocks.

  def biblio_commons_mock
    OpenStruct.new(
      :user_id       => 42,
      :name          => 'Top 10 Great American Novels',
      :thumbnail_url => 'http://example.com/image.jpg',
      :url           => 'http://example.com/'
    )
  end
end
