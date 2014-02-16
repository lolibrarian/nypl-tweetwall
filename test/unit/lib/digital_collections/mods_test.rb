require 'test_helper'

class DigitalCollections::MODSTest < ActiveSupport::TestCase
  def test_mods_uuid_from_url
    url = 'http://digitalcollections.nypl.org/items/510d47e2-e8ca-a3d9-e040-e00a18064a99'
    id = DigitalCollections::MODS.mods_uuid_from_url(url)
    assert_equal '510d47e2-e8ca-a3d9-e040-e00a18064a99', id
  end

  def test_mods_uuid_from_url_invalid
    url = 'http://www.nypl.org/locations/schwarzman'
    id = DigitalCollections::MODS.mods_uuid_from_url(url)
    assert_nil id
  end

  def test_url
    expected_url = 'http://digitalcollections.nypl.org/items/510d47e2-e8ca-a3d9-e040-e00a18064a99'
    mods = DigitalCollections::MODS.new('510d47e2-e8ca-a3d9-e040-e00a18064a99')
    assert_equal expected_url, mods.url
  end

  def test_title_one
    stub = mods_stub(:one_title)
    expected_title = "Publicity still from the film A Hard Day's Night [1964]."
    mods = DigitalCollections::MODS.new('510d47e2-e8ca-a3d9-e040-e00a18064a99')
    mods.stub(:mods, stub) do
      assert_equal expected_title, mods.title
    end
  end

  def test_title_many
    stub = mods_stub(:many_titles)
    expected_title = 'The bride wore red. Joan Crawford as Anni Pavelevitch. ' +
                     'Robert Young as Rudi Pal.'
    mods = DigitalCollections::MODS.new('510d47e2-e8ca-a3d9-e040-e00a18064a99')
    mods.stub(:mods, stub) do
      assert_equal expected_title, mods.title
    end
  end

private

  def mods_stub(name)
    fixture_pathname = Pathname.new(fixture_path) + "api/digital_collections/mods_#{name}.yml"
    YAML.load(fixture_pathname.read)
  end
end
