require 'test_helper'

class BiblioCommons::ListTest < ActiveSupport::TestCase
  def test_id_from_url_show
    url = 'http://nypl.bibliocommons.com/list/show/87524369_nypl_mid_manhattan/104438791_the_10_most_divisive_characters_in_literary_history'
    id = BiblioCommons::List.id_from_url(url)
    assert_equal '104438791', id
  end

  def test_id_from_url_share
    url = 'http://nypl.bibliocommons.com/list/share/87524369_nypl_mid_manhattan/104438791_the_10_most_divisive_characters_in_literary_history'
    id = BiblioCommons::List.id_from_url(url)
    assert_equal '104438791', id
  end

  def test_id_from_url_invalid
    url = 'http://www.nypl.org/locations/schwarzman'
    id = BiblioCommons::List.id_from_url(url)
    assert_nil id
  end

  def test_url
    expected_url = 'http://nypl.bibliocommons.com/list/show/234857057/104438791'
    list = BiblioCommons::List.new('104438791', '234857057')
    assert_equal expected_url, list.url
  end

  def test_name
    list = BiblioCommons::List.new('104438791')
    list.stub(:lists, lists_stub) do
      assert_equal 'The 25 Most Important LGBT Films', list.name
    end
  end

  def test_user_id
    list = BiblioCommons::List.new('104438791')
    list.stub(:lists, lists_stub) do
      assert_equal '234857057', list.user_id
    end
  end

  def test_thumbnail_url
    skip 'TODO: difficult to test without MiniTest extensions and/or Mocha'
  end

private

  def lists_stub
    fixture_pathname = Pathname.new(fixture_path) + 'api/biblio_commons/lists.yml'
    YAML.load(fixture_pathname.read)
  end
end
