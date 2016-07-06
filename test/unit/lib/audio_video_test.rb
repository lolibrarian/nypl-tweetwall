require 'test_helper'

class AudioVideoTest < ActiveSupport::TestCase
  def test_id_from_url
    url = 'http://www.nypl.org/audiovideo/tommy-turrentine-trumpet?nref=90302'
    id = AudioVideo.id_from_url(url)
    assert_equal 'tommy-turrentine-trumpet', id
  end

  def test_id_from_url_invalid
    url = 'http://www.nypl.org/locations/schwarzman'
    id = AudioVideo.id_from_url(url)
    assert_nil id
  end

  def test_uri
    expected_uri = URI('https://www.nypl.org/audiovideo/tommy-turrentine-trumpet')
    exhibition = AudioVideo.new('tommy-turrentine-trumpet')
    assert_equal expected_uri, exhibition.uri
  end

  def test_title
    exhibition = AudioVideo.new('tommy-turrentine-trumpet')
    exhibition.stub(:document, document_stub) do
      assert_equal 'Tommy Turrentine, trumpet', exhibition.title
    end
  end

  def test_thumbnail_url
    expected_thumbnail_url = 'http://cdn-prod.www.aws.nypl.org/sites/default/' +
                             'files/images/av/jazz_1993_08_12_turrentine.jpeg'
    exhibition = AudioVideo.new('tommy-turrentine-trumpet')
    exhibition.stub(:document, document_stub) do
      assert_equal expected_thumbnail_url, exhibition.thumbnail_url
    end
  end

private

  def document_stub
    fixture_pathname = Pathname.new(fixture_path) + 'html/audio_video.html'
    Nokogiri::HTML(fixture_pathname.read)
  end
end
