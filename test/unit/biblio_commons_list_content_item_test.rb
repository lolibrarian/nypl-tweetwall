require 'test_helper'

class BiblioCommonsListContentItemTest < ActiveSupport::TestCase
  def setup
    @content_item = BiblioCommonsListContentItem.new
  end

  def test_fetch_metadata_user_id
    @content_item.stub(:biblio_commons, biblio_commons_stub) do
      assert_nil @content_item.user_id
      @content_item.fetch_metadata
      assert_equal biblio_commons_stub.user_id, @content_item.user_id
    end
  end

  def test_fetch_metadata_title
    @content_item.stub(:biblio_commons, biblio_commons_stub) do
      assert_nil @content_item.title
      @content_item.fetch_metadata
      assert_equal biblio_commons_stub.name, @content_item.title
    end
  end

  def test_fetch_metadata_thumbnail
    without_fetching_remote_images do
      @content_item.stub(:biblio_commons, biblio_commons_stub) do
        assert_nil @content_item.thumbnail
        @content_item.fetch_metadata
        assert_equal biblio_commons_stub.thumbnail_url, @content_item.thumbnail.url
      end
    end
  end

  def test_url
    @content_item.stub(:biblio_commons, biblio_commons_stub) do
      assert_equal biblio_commons_stub.url, @content_item.url
    end
  end

private

  def biblio_commons_stub
    OpenStruct.new(
      :user_id       => 42,
      :name          => 'Top 10 Great American Novels',
      :thumbnail_url => 'http://example.com/image.jpg',
      :url           => 'http://example.com/'
    )
  end
end
