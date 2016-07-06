require 'test_helper'

class ExhibitionTest < ActiveSupport::TestCase
  def test_id_from_url
    url = 'http://www.nypl.org/events/exhibitions/breaking-barriers-ata-and-black-tennis-pioneers'
    id = Exhibition.id_from_url(url)
    assert_equal 'breaking-barriers-ata-and-black-tennis-pioneers', id
  end

  def test_id_from_url_invalid
    url = 'http://www.nypl.org/locations/schwarzman'
    id = Exhibition.id_from_url(url)
    assert_nil id
  end

  def test_uri
    expected_uri = URI('https://www.nypl.org/events/exhibitions/breaking-barriers-ata-and-black-tennis-pioneers')
    exhibition = Exhibition.new('breaking-barriers-ata-and-black-tennis-pioneers')
    assert_equal expected_uri, exhibition.uri
  end

  def test_title
    exhibition = Exhibition.new('abc-it')
    exhibition.stub(:document, document_stub) do
      assert_equal "The ABC of It: Why Children's Books Matter", exhibition.title
    end
  end

  def test_thumbnail_url
    expected_thumbnail_url = 'http://cdn-prod.www.aws.nypl.org/sites/default/' +
                             'files/images/cow-over-moon.jpg'
    exhibition = Exhibition.new('abc-it')
    exhibition.stub(:document, document_stub) do
      assert_equal expected_thumbnail_url, exhibition.thumbnail_url
    end
  end

private

  def document_stub
    fixture_pathname = Pathname.new(fixture_path) + 'html/exhibition.html'
    Nokogiri::HTML(fixture_pathname.read)
  end
end
