require 'test_helper'

class RemoteImageTest < ActiveSupport::TestCase
  def setup
    @remote_image = RemoteImage.new
  end

  def test_encoded_url_unencoded
    actual_url = 'https://www.nypl.org/sites/default/files/Literary World Cup - semifinals.jpg'
    expected_url = 'https://www.nypl.org/sites/default/files/Literary%20World%20Cup%20-%20semifinals.jpg'

    @remote_image.url = actual_url
    assert_equal expected_url, @remote_image.encoded_url
  end

  def test_encoded_url_already_encoded
    actual_url   = 'https://www.nypl.org/sites/default/files/Literary%20World%20Cup%20-%20semifinals.jpg'
    expected_url = 'https://www.nypl.org/sites/default/files/Literary%20World%20Cup%20-%20semifinals.jpg'

    @remote_image.url = actual_url
    assert_equal expected_url, @remote_image.encoded_url
  end
end
