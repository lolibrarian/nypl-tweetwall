require 'test_helper'

class DigitalGalleryTest < ActiveSupport::TestCase
  def test_id_from_url
    url = 'http://digitalgallery.nypl.org/nypldigital/dgkeysearchdetail.cfm?imageID=813029'
    id = DigitalGallery.id_from_url(url)
    assert_equal '813029', id
  end

  def test_id_from_url_invalid
    url = 'http://www.nypl.org/locations/schwarzman'
    id = DigitalGallery.id_from_url(url)
    assert_nil id
  end

  def test_uri
    expected_uri = URI('http://digitalgallery.nypl.org/nypldigital/dgkeysearchdetail.cfm?imageID=813029')
    digital_gallery = DigitalGallery.new('813029')
    assert_equal expected_uri, digital_gallery.uri
  end

  def test_title
    digital_gallery = DigitalGallery.new('813029')
    digital_gallery.stub(:document, document_stub) do
      assert_equal 'Borden - Cows - Cow marriage', digital_gallery.title
    end
  end

  def test_thumbnail_uri
    expected_thumbnail_uri = URI('http://images.nypl.org/index.php?id=813029&t=w')
    digital_gallery = DigitalGallery.new('813029')
    digital_gallery.stub(:document, document_stub) do
      assert_equal expected_thumbnail_uri, digital_gallery.thumbnail_uri
    end
  end

private

  def document_stub
    fixture_pathname = Pathname.new(fixture_path) + 'html/digital_gallery.html'
    Nokogiri::HTML(fixture_pathname.read)
  end
end
