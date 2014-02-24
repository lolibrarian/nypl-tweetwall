require 'test_helper'

class BiblioCommons::TitleTest < ActiveSupport::TestCase
  def test_id_from_url
    url = 'http://nypl.bibliocommons.com/item/show/17213885052907'
    id = BiblioCommons::Title.id_from_url(url)
    assert_equal '17213885052907', id
  end

  def test_id_from_url_invalid
    url = 'http://www.nypl.org/locations/schwarzman'
    id = BiblioCommons::Title.id_from_url(url)
    assert_nil id
  end

  def test_url
    expected_url = 'http://nypl.bibliocommons.com/item/show/17213885052907'
    title = BiblioCommons::Title.new('17213885052907')
    assert_equal expected_url, title.url
  end

  def test_title
    title = BiblioCommons::Title.new('19477049052907')
    title.stub(:titles, titles_stub) do
      assert_equal 'The Expats', title.title
    end
  end

  def test_thumbnail_url_found
    expected_thumbnail_url = 'http://contentcafe2.btol.com/ContentCafe/Jacket.aspx' +
                             '?userID&password&Value=9780307956354&Type=M&Return=1'
    title = BiblioCommons::Title.new('19477049052907')
    title.stub(:titles, titles_stub) do
      without_fetching_remote_images do
        assert_equal expected_thumbnail_url, title.thumbnail_url
      end
    end
  end

  def test_thumbnail_url_default
    expected_thumbnail_url = NYPLContentType::DEFAULT_THUMBNAIL_URL
    title = BiblioCommons::Title.new('19477049052907')
    title.stub(:first_available_jacket_image_url, nil) do
      assert_equal expected_thumbnail_url, title.thumbnail_url
    end
  end

  def test_format
    title = BiblioCommons::Title.new('19477049052907')
    title.stub(:titles, titles_stub) do
      assert_equal 'BK', title.format
    end
  end

private

  def titles_stub
    fixture_pathname = Pathname.new(fixture_path) + 'api/biblio_commons/titles.yml'
    YAML.load(fixture_pathname.read)
  end
end
