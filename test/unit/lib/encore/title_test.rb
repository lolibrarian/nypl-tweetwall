require 'test_helper'

class Encore::TitleTest < ActiveSupport::TestCase
  def test_id_from_url
    url = 'http://browse.nypl.org/iii/encore/record/C__Rb20635418'
    id = Encore::Title.id_from_url(url)
    assert_equal 'b20635418', id
  end

  def test_id_from_url_invalid
    url = 'http://www.nypl.org/locations/schwarzman'
    id = Encore::Title.id_from_url(url)
    assert_nil id
  end

  def test_url
    expected_url = 'http://browse.nypl.org/iii/encore/record/C__Rb20635418'
    title = Encore::Title.new('b20635418')
    assert_equal expected_url, title.url
  end

  def test_title
    title = Encore::Title.new('b20816957')
    title.stub(:document, document_stub) do
      assert_equal "Mark Bittman's kitchen express [electronic resource] : 404 inspired seasonal dishes you can make in 20 minutes or less", title.title
    end
  end

  def test_thumbnail_url_found
    expected_thumbnail_url = 'http://contentcafe2.btol.com/ContentCafe/Jacket.aspx' +
                             '?userID&password&Value=9781416578987&Type=M&Return=1'
    title = Encore::Title.new('b20816957')
    title.stub(:document, document_stub) do
      without_fetching_remote_images do
        assert_equal expected_thumbnail_url, title.thumbnail_url
      end
    end
  end

  def test_thumbnail_url_default
    expected_thumbnail_url = NYPLContentType::DEFAULT_THUMBNAIL_URL
    title = Encore::Title.new('b20816957')
    title.stub(:jacket_image_url, nil) do
      assert_equal expected_thumbnail_url, title.thumbnail_url
    end
  end

  def test_format
    title = Encore::Title.new('b20816957')
    title.stub(:document, document_stub) do
      assert_equal 'E-BOOK', title.format
    end
  end

  private

  def document_stub
    fixture_pathname = Pathname.new(fixture_path) + 'html/encore_title.html'
    Nokogiri::HTML(fixture_pathname.read)
  end
end
