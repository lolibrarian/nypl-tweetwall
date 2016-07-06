require 'test_helper'

class ProgramTest < ActiveSupport::TestCase
  def test_id_from_url
    url = 'http://www.nypl.org/events/programs/2013/09/17/yoga-seniors'
    id = Program.id_from_url(url)
    assert_equal '2013/09/17/yoga-seniors', id
  end

  def test_id_from_url_invalid
    url = 'http://www.nypl.org/locations/schwarzman'
    id = Program.id_from_url(url)
    assert_nil id
  end

  def test_uri
    expected_uri = URI('https://www.nypl.org/events/programs/2013/09/17/yoga-seniors')
    program = Program.new('2013/09/17/yoga-seniors')
    assert_equal expected_uri, program.uri
  end

  def test_title
    program = Program.new('2014/02/15/disney-family-film-petes-dragon')
    program.stub(:document, document_stub) do
      assert_equal "DISNEY FAMILY FILM - PETE'S DRAGON", program.title
    end
  end

  def test_thumbnail_url
    expected_thumbnail_url = 'http://cdn-prod.www.aws.nypl.org/sites/default/' +
                             'files/images/petes_dragon.inline vertical.jpg'
    program = Program.new('2014/02/15/disney-family-film-petes-dragon')
    program.stub(:document, document_stub) do
      assert_equal expected_thumbnail_url, program.thumbnail_url
    end
  end

private

  def document_stub
    fixture_pathname = Pathname.new(fixture_path) + 'html/program.html'
    Nokogiri::HTML(fixture_pathname.read)
  end
end
