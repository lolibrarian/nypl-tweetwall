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
    expected_uri = URI('http://www.nypl.org/events/programs/2013/09/17/yoga-seniors')
    program = Program.new('2013/09/17/yoga-seniors')
    assert_equal expected_uri, program.uri
  end

  def test_title
    program = Program.new('2013/09/17/yoga-seniors')
    program.stub(:document, document_stub) do
      assert_equal 'Yoga for Seniors', program.title
    end
  end

  def test_thumbnail_url
    program = Program.new('2013/09/17/yoga-seniors')
    program.stub(:document, document_stub) do
      assert_equal 'http://images.nypl.org/?id=1531664 &t=w', program.thumbnail_url
    end
  end

private

  def document_stub
    fixture_pathname = Pathname.new(fixture_path) + 'html/program.html'
    Nokogiri::HTML(fixture_pathname.read)
  end
end
